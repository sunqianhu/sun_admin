<?php

namespace app\service\desktop;

use app\entity\SessionEntity;
use app\model\UserModel;
use app\service\user\desktop\User;
use app\service\Config;
use app\service\LoginLog;
use Exception;

class Session
{
    public $isTokenAuth = true; //是否token认证
    public $noTokenAuthActions = []; //不需要token认证的方法
    public $isRouteAuth = true; //是否路由认证
    public $noRouteAuthActions = []; //不需要路由认证的方法

    /**
     * 登录
     * @param $account
     * @param $password
     * @param $ip
     * @return SessionEntity
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function login($account, $password, $ip = '')
    {
        $userModel = UserModel::field('id,department_id,status_id,name')
            ->where('account', $account)
            ->where('password', md5($password))
            ->find();
        if (empty($userModel)) {
            throw new Exception('用户名或密码错误');
        }
        if ($userModel->status_id == 0) {
            throw new Exception('账号已停用');
        }

        $jwt = new Jwt();
        $token = $jwt->getToken($userModel->id);

        //登录日志
        $loginLog = new LoginLog();
        $loginLog->add($userModel->id, $ip);

        //用户表
        $userModel->login_time = time();
        $userModel->login_ip = $ip;
        $userModel->save();

        $session = new SessionEntity();
        $session->userId = $userModel->id;
        $session->departmentId = $userModel->department_id;
        $session->token = $token;

        return $session;
    }

    /**
     * 退出登录
     * @param $token
     * @return void
     */
    public function logout($token)
    {
        $jwt = new Jwt();
        $jwt->deleteToken($token);
    }

    /**
     * ip认证
     * @param $ip
     * @return true
     * @throws Exception
     */
    function ipAuth($ip)
    {
        $config = new Config();
        $deniedIpString = $config->getValue('denied_ip_string');
        $deniedIps = explode("\r\n", $deniedIpString);
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
     * @return SessionEntity
     */
    function tokenAuth($token, $action)
    {
        $jwt = new Jwt();
        $isAuth = $this->isTokenAuth;
        if (in_array($action, $this->noTokenAuthActions)) {
            $isAuth = false;
        }
        if (!$isAuth) {
            try {
                return $jwt->resolverToken($token);
            } catch (Exception $exception) {
                return new SessionEntity();
            }
        }

        return $jwt->resolverToken($token);
    }

    /**
     * 路由认证
     * @param $userId
     * @param $route
     * @param $action
     * @return void
     * @throws Exception
     */
    function ruoteAuth($userId, $route, $action)
    {
        $isAuth = $this->isTokenAuth && $this->isRouteAuth;
        if (in_array($action, $this->noRouteAuthActions)) {
            $isAuth = false;
        }
        if (!$isAuth) {
            return;
        }

        if (empty($userId)) {
            throw new Exception('路由认证，用户id不能为空');
        }
        if ($route === '') {
            throw new Exception('路由认证，路由不能为空');
        }

        $user = new User();
        if (!$user->hasApiPermission($userId, $route)) {
            throw new Exception('无权限');
        }
    }
}