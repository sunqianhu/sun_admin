<?php

namespace app\helper;

use app\helper\user\UserDesktopPermissionHelper;
use app\helper\user\UserMobilePermissionHelper;
use app\model\LoginLogModel;
use app\model\SessionModel;
use app\model\UserModel;
use Exception;

class SessionHelper
{
    /**
     * 添加会话
     * @param array $data 会话数据，包含user_id、terminal、token、expire_time等字段
     * @return int
     * @throws Exception
     */
    public function add(array $data)
    {
        $data['add_time'] = $data['add_time'] ?? time();
        $sessionModel = new SessionModel();
        $sessionModel->save($data);

        return $sessionModel->id;
    }

    /**
     * 删除会话
     * @param $id
     * @throws Exception
     */
    public function delete($id)
    {
        $sessionModel = SessionModel::find($id);
        if (empty($sessionModel)) {
            throw new Exception('没有找到会话记录');
        }
        $sessionModel->delete();
    }

    /**
     * 通过用户ID删除会话，未指定终端时删除三端全部会话
     * @param $userId
     * @param int|null $terminal
     * @return bool
     */
    public function deleteByUserId($userId, $terminal = null)
    {
        $query = SessionModel::where('user_id', $userId);
        if ($terminal !== null) {
            $query->where('terminal', $terminal);
        }
        return $query->delete();
    }

    /**
     * 登录
     * @param int $terminal
     * @param $account
     * @param $password
     * @param string $ip
     * @param int $expireTime 到期时间戳
     * @return int
     * @throws Exception
     */
    public function login($terminal, $account, $password, $ip, $expireTime)
    {
        //登录次数
        $loginCountCheckerHelper = new LoginCountCheckerHelper($account);
        if (!$loginCountCheckerHelper->check()) {
            $message = '连续登录失败'.$loginCountCheckerHelper->number
                .'次，请'.$loginCountCheckerHelper->getResetReadableTime().'后再试';
            throw new Exception($message);
        }

        $userModel = UserModel::field('id,department_id,status,password')
            ->where('account', $account)
            ->find();
        if (empty($userModel) || !password_verify($password, $userModel->password)) {
            $loginCountCheckerHelper->setFail();
            $availableNumber = $loginCountCheckerHelper->getAvailableNumber();
            $message = '账号或密码错误';
            if ($availableNumber > 0) {
                $message .= '，还能再试'.$availableNumber.'次';
            } else {
                $message .= '，连续登录失败'.$loginCountCheckerHelper->number.'次，请'.$loginCountCheckerHelper->getResetReadableTime().'后再试';
            }
            throw new Exception($message);
        }
        if ((int) $userModel->status !== 1) {
            throw new Exception('账号未启用');
        }

        $jwtHelper = new JwtHelper();
        $data = [
            'user_id' => $userModel->id,
            'terminal' => $terminal,
            'token' => $jwtHelper->generateToken($userModel->id),
            'expire_time' => $expireTime
        ];
        $sessionId = $this->add($data);

        //登录日志
        $time = time();
        $loginLogModel = new LoginLogModel();
        $loginLogModel->save([
            'department_id' => $userModel->department_id,
            'user_id' => $userModel->id,
            'terminal' => $terminal,
            'ip' => $ip,
            'time' => $time
        ]);

        //用户表
        $userModel->last_login_time = $time;
        $userModel->last_login_ip = $ip;
        $userModel->save();

        $loginCountCheckerHelper->resetFail();

        return $sessionId;
    }

    /**
     * token认证
     * @param int $terminal
     * @param $token
     * @return int
     * @throws Exception
     */
    public function tokenAuth(int $terminal, $token)
    {
        if (!is_string($token) || $token === '') {
            throw new Exception('未登录');
        }
        $jwtHelper = new JwtHelper();
        $userId = $jwtHelper->resolverToken($token);

        $sessionModel = SessionModel::where('token', $token)
            ->where('terminal', $terminal)
            ->find();
        if (empty($sessionModel)) {
            throw new Exception('未登录');
        }
        if ($sessionModel->expire_time <= time()) {
            throw new Exception('登录已过期');
        }
        if ($sessionModel->user_id != $userId) {
            throw new Exception('登录凭证错误');
        }

        $userModel = UserModel::field('id,status')->find($userId);
        if (empty($userModel)) {
            throw new Exception('账号不存在');
        }
        if ((int) $userModel->status !== 1) {
            throw new Exception('账号未启用');
        }

        return $sessionModel->id;
    }

    /**
     * 续期
     * @param $id
     * @param int $expireTime 新的到期时间戳
     * @return void
     * @throws Exception
     */
    public function renewExpireTime($id, int $expireTime)
    {
        $sessionModel = SessionModel::find($id);
        if (empty($sessionModel)) {
            throw new Exception('没有找到会话记录');
        }
        if ($sessionModel->expire_time <= time()) {
            throw new Exception('登录已过期');
        }
        $sessionModel->expire_time = $expireTime;
        $sessionModel->save();
    }

    /**
     * 桌面端及移动端接口认证
     * @param int $terminal
     * @param $userId
     * @param string $api
     * @return true
     * @throws Exception
     */
    public function apiAuth($terminal, $userId, string $api)
    {
        if (empty($userId)) {
            throw new Exception('用户ID不能为空');
        }
        if ($api === '') {
            throw new Exception('接口不能为空');
        }
        if (!in_array($terminal, [0, 1], true)) {
            throw new Exception('当前终端不支持接口权限校验');
        }

        if ($terminal === 0) {
            $permissionHelper = new UserDesktopPermissionHelper();
            if (!$permissionHelper->hasPermissionByApi($userId, $api)) {
                throw new Exception('无权限');
            }
        }

        if ($terminal === 1) {
            $permissionHelper = new UserMobilePermissionHelper();
            if (!$permissionHelper->hasPermissionByApi($userId, $api)) {
                throw new Exception('无权限');
            }
        }

        return true;
    }

    /**
     * 得到token
     * @param $id
     * @return string
     * @throws Exception
     */
    public function getToken($id)
    {
        $sessionModel = SessionModel::field('token')
            ->find($id);
        if (empty($sessionModel)) {
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
        $sessionModel = SessionModel::field('user_id')
            ->find($id);
        if (empty($sessionModel)) {
            throw new Exception('没有找到会话记录');
        }
        return $sessionModel->user_id;
    }
}
