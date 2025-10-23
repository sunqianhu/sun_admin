<?php

namespace app\helper\mobile;

use app\model\LoginLogModel;
use app\model\mobile\SessionModel;
use app\model\UserModel;
use app\helper\JwtHelper;
use app\helper\user\UserMobilePermissionHelper;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class SessionHelper
{
    public int $expire = 60 * 60 * 24 * 7; //有效期

    /**
     * 创建会话
     * @param $userId
     * @param $token
     * @return int
     */
    public function createSession($userId, $token)
    {
        $data = [
            'user_id' => $userId,
            'token' => $token,
            'expires_in' => time() + $this->expire
        ];
        $sessionModel = new SessionModel();
        $sessionModel->save($data);
        return $sessionModel->id;
    }

    /**
     * 删除会话
     * @param $id
     * @throws Exception
     */
    public function deleteSession($id)
    {
        $sessionModel = SessionModel::find($id);
        if(empty($sessionModel)){
            throw new Exception('没有找到会话记录');
        }
        $sessionModel->delete();
    }

    /**
     * 通过用户ID删除会话
     * @param $userId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function deleteSessionByUserId($userId){
        $sessionModels = SessionModel::where('user_id', $userId)->select();
        if ($sessionModels->isEmpty()) {
            throw new Exception('没有找到会话记录');
        }
        $sessionModels->delete();
    }

    /**
     * 登录
     * @param $account
     * @param $password
     * @param $ip
     * @return int
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function login($account, $password, $ip = '')
    {
        $userModel = UserModel::field('id,department_id,status,name')
            ->where('account', $account)
            ->where('password', md5($password))
            ->find();
        if (empty($userModel)) {
            throw new Exception('用户名或密码错误');
        }
        if ($userModel->status == 0) {
            throw new Exception('账号已停用');
        }

        $jwtHelper = new JwtHelper();
        $token = $jwtHelper->generateToken($userModel->id);
        $sessionId = $this->createSession($userModel->id, $token);

        //登录日志
        $loginLogModel = new LoginLogModel();
        $data = [
            'user_id' => $userModel->id,
            'ip' => $ip,
            'time' => time()
        ];
        $loginLogModel->save($data);

        //用户表
        $userModel->last_login_time = time();
        $userModel->last_login_ip = $ip;
        $userModel->save();

        return $sessionId;
    }

    /**
     * token认证
     * @param $token
     * @return int
     * @throws Exception
     */
    function tokenAuth($token)
    {
        if($token === ''){
            throw new Exception('未登录');
        }
        $jwtHelper = new JwtHelper();
        $userId = $jwtHelper->resolverToken($token);

        $sessionModel = SessionModel::where('token', $token)->find();
        if(empty($sessionModel)){
            throw new Exception('未登录');
        }
        if ($sessionModel->expires_in < time()) {
            throw new Exception('登录已过期');
        }
        if ($sessionModel->user_id != $userId) {
            throw new Exception('登录凭证错误');
        }

        return $sessionModel->id;
    }

    /**
     * 续期
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function renewExpiresIn($id)
    {
        $sessionModel = SessionModel::find($id);
        if(empty($sessionModel)){
            throw new Exception('没有找到会话记录');
        }
        $sessionModel->expires_in = time() + $this->expire;
        $sessionModel->save();
    }

    /**
     * 接口认证
     * @param $userId
     * @param $api
     * @return void
     * @throws Exception
     */
    function apiAuth($userId, $api)
    {
        if (empty($userId)) {
            throw new Exception('接口认证，用户id不能为空');
        }
        if ($api === '') {
            throw new Exception('接口认证，接口不能为空');
        }

        $userMobilePermissionHelper = new UserMobilePermissionHelper();
        if (!$userMobilePermissionHelper->hasPermissionByApi($userId, $api)) {
            throw new Exception('无权限');
        }
    }

    /**
     * 得到token
     * @param $id
     * @return string
     * @throws Exception
     */
    public function getToken($id)
    {
        $sessionModel = SessionModel::field('token')->find($id);
        if(empty($sessionModel)){
            throw new Exception('没有找到会话记录');
        }
        return $sessionModel->token;
    }

    /**
     * 得到用户id
     * @param $id
     * @return int
     * @throws Exception
     */
    public function getUserId($id)
    {
        $sessionModel = SessionModel::field('user_id')->find($id);
        if(empty($sessionModel)){
            throw new Exception('没有找到会话记录');
        }
        return $sessionModel->user_id;
    }
}