<?php

namespace app\service\api;

use app\entity\SessionEntity;
use app\model\UserModel;
use app\service\Config;
use app\service\LoginLog;
use Exception;

class Session
{
    public $isTokenAuth = true; //是否token认证
    public $noTokenAuthActions = []; //不需要token认证的方法

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
        $user = UserModel::field('id,department_id,status,name')
            ->where('account', $account)
            ->where('password', md5($password))
            ->find();
        if (empty($user)) {
            throw new Exception('账号或密码错误');
        }
        if ($user->status == 0) {
            throw new Exception('账号已停用');
        }

        $jwt = new Jwt();
        $token = $jwt->createToken($user->id);

        //登录日志
        $loginLog = new LoginLog();
        $data = [
            'user_id' => $user->id,
            'ip' => $ip,
            'time' => time()
        ];
        $loginLog->add($data);

        //用户表
        $user->last_login_time = time();
        $user->last_login_ip = $ip;
        $user->save();

        $session = new SessionEntity();
        $session->userId = $user->id;
        $session->departmentId = $user->department_id;
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
        $token = new Token();
        $token->fieldDelete('token', $token);
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
}