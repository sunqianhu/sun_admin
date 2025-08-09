<?php

namespace app\service\mobile;

use app\model\ConfigModel;
use app\model\LoginLogModel;
use app\model\mobile\SessionModel;
use app\model\UserModel;
use app\service\JwtService;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class SessionService
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public bool $isApiAuth = true; //是否接口认证
    public array $noApiAuthActions = []; //不需要接口认证的方法
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
        return $sessionModel->save($data);
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

        $jwtService = new JwtService();
        $token = $jwtService->generateToken($userModel->id);
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
     * 退出登录
     * @param $id
     * @return void
     * @throws Exception
     */
    public function logout($id)
    {
        $this->deleteSession($id);
    }

    /**
     * ip认证
     * @param $ip
     * @return true
     * @throws Exception
     */
    function ipAuth($ip)
    {
        $configModel = ConfigModel::find(1);
        if(empty($configModel)){
            throw new Exception('没有找到系统配置记录');
        }
        $deniedIpString = $configModel->denied_ip_string;
        $deniedIps = explode("\r\n", $deniedIpString);
        $deniedIps = array_filter($deniedIps);
        if (empty($deniedIps)) {
            return true;
        }
        if (in_array($ip, $deniedIps)) {
            throw new Exception('您的ip已被拒绝访问');
        }
        return true;
    }

    /**
     * token认证
     * @param $token
     * @param $action
     * @return int
     * @throws Exception
     */
    function tokenAuth($token, $action)
    {
        $isAuth = $this->isTokenAuth;
        if (in_array($action, $this->noTokenAuthActions)) {
            $isAuth = false;
        }
        if (!$isAuth) {
            return 0;
        }

        if($token === ''){
            throw new Exception('未登录');
        }
        $jwtService = new JwtService();
        $userId = $jwtService->resolverToken($token);

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
        $sessionModel->save(['expires_in' => time() + $this->expire]);

        return $sessionModel->id;
    }

    /**
     * 接口认证
     * @param $userId
     * @param $api
     * @param $action
     * @return void
     * @throws Exception
     */
    function apiAuth($userId, $api, $action)
    {
        $isAuth = $this->isTokenAuth && $this->isApiAuth;
        if (in_array($action, $this->noApiAuthActions)) {
            $isAuth = false;
        }
        if (!$isAuth) {
            return;
        }

        if (empty($userId)) {
            throw new Exception('接口认证，用户id不能为空');
        }
        if ($api === '') {
            throw new Exception('接口认证，接口不能为空');
        }

        $mobileUserService = new MobileUserService();
        if (!$mobileUserService->hasApiPermission($userId, $api)) {
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