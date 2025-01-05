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
    public $isIpAuth = true;
    public $isTokenAuth = true;
    public $isRouteAuth = true;

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
        if ($userModel->status_id == 2) {
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
    function ipAuth($ip){
        if(!$this->isIpAuth){
            return true;
        }
        $config = new Config();
        $deniedIpString = $config->getValue('denied_ip_string');
        $deniedIps = explode("\r\n", $deniedIpString);
        if(empty($deniedIps)){
            return true;
        }
        if(in_array($ip, $deniedIps)){
            throw new Exception('您的ip已被拒绝访问');
        }
        return true;
    }

    /**
     * token认证
     * @param $request
     * @return SessionEntity
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    function tokenAuth($request)
    {
        $token = $request->header('token', '');
        if(!$this->isTokenAuth){
            return (new SessionEntity());
        }

        $jwt = new Jwt();
        return $jwt->resolverToken($token);
    }

    /**
     * 路由认证
     * @param $request
     * @return void
     * @throws Exception
     */
    function ruoteAuth($request, $userId)
    {
        if(!$this->isTokenAuth || !$this->isRouteAuth){
            return;
        }
        if(empty($userId)){
            throw new Exception('用户id不能为空');
        }

        $url = $request->baseUrl();
        $url = strtolower($url);
        $url = ltrim($url, '/');
        $user = new User();
        if(!$user->hasApiPermission($userId, $url)){
            throw new Exception('无权限');
        }
    }
}