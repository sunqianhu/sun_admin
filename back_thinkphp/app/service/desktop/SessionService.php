<?php

namespace app\service\desktop;

use app\entity\Session;
use app\model\ConfigModel;
use app\model\desktop\TokenModel;
use app\model\LoginLogModel;
use app\model\UserModel;
use app\service\CrudService;
use Exception;

class SessionService
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public bool $isApiAuth = true; //是否接口认证
    public array $noApiAuthActions = []; //不需要接口认证的方法

    /**
     * 登录
     * @param $account
     * @param $password
     * @param $ip
     * @return Session
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function login($account, $password, $ip = '')
    {
        $userModel = UserModel::field('id,department_id,status,name')
            ->where('account', $account)
            ->where('password', md5($password))
            ->find();
        if (empty($userModel)) {
            throw new Exception('账号或密码错误');
        }
        if ($userModel->status == 0) {
            throw new Exception('账号已停用');
        }

        $jwtService = new JwtService();
        $token = $jwtService->createToken($userModel->id);

        //登录日志
        $loginLogCrudService = new CrudService(LoginLogModel::class);
        $data = [
            'user_id' => $userModel->id,
            'ip' => $ip,
            'time' => time()
        ];
        $loginLogCrudService->add($data);

        //用户表
        $userModel->last_login_time = time();
        $userModel->last_login_ip = $ip;
        $userModel->save();

        $session = new Session();
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
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenCrudService->deleteByField('token', $token);
    }

    /**
     * ip认证
     * @param $ip
     * @return bool
     * @throws Exception
     */
    function ipAuth($ip)
    {
        $configCrudService = new CrudService(ConfigModel::class);
        $deniedIpString = $configCrudService->getValue(1,'denied_ip_string');
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
     * @return Session
     */
    function tokenAuth($token, $action)
    {
        $jwtService = new JwtService();
        $isAuth = $this->isTokenAuth;
        if (in_array($action, $this->noTokenAuthActions)) {
            $isAuth = false;
        }
        if (!$isAuth) {
            try{
                return $jwtService->resolverToken($token);
            }catch (Exception $exception){
                return new Session();
            }
        }

        return $jwtService->resolverToken($token);
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
            throw new Exception('接口认证，路由不能为空');
        }

        $desktopUserService = new DesktopUserService();
        if (!$desktopUserService->hasApiPermission($userId, $api)) {
            throw new Exception('无权限');
        }
    }
}