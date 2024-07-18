<?php

namespace app\service\mobile;

use app\entity\mobile\Session as SessionEntity;
use app\entity\User as UserEntity;
use app\model\User as UserModel;
use app\service\Config as ConfigService;
use app\service\mobile\session\Jwt;
use app\service\LoginLog as LoginLogService;
use app\service\user\Mobile as MobileService;
use Exception;

class Session
{
    /**
     * @var string[] 不登录网址
     */
    public $noLoginUrls = [
        '/mobile/Login/login',
        '/mobile/Test/index'
    ];

    /**
     * @var string[] 不鉴权网址
     */
    public $noAuthUrls = [
        '/desktop/uploadFile/upload'
    ];

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
    public function login($account, $password, $ip)
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
        $userEntity = new UserEntity();
        $userEntity->id = $userModel->id;
        $userEntity->name = $userModel->name;
        $userEntity->departmentId = $userModel->department_id;
        $token = $jwt->getToken($userEntity);

        //登录日志
        $loginLogService = new LoginLogService();
        $loginLogService->add($userModel->id, $ip);

        //用户表
        $userModel->login_time = time();
        $userModel->login_ip = $ip;
        $userModel->save();

        $sessionEntity = new SessionEntity();
        $sessionEntity->user = $userEntity;
        $sessionEntity->token = $token;

        return $sessionEntity;
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
        $configService = new ConfigService();
        $deniedIpString = $configService->getValue('denied_ip_string');
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
     * @return SessionEntity|true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    function tokenAuth($request)
    {
        $token = $request->header('token', '');
        $url = $request->baseUrl();
        $url = strtolower($url);
        $this->noLoginUrls = array_map('strtolower', $this->noLoginUrls);

        if (in_array($url, $this->noLoginUrls)) {
            try{
                $jwt = new Jwt();
                return $jwt->resolverToken($token);
            }catch (Exception $exception){}
            return;
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
        if(empty($userId)){
            throw new Exception('用户id不能为空');
        }

        $url = $request->baseUrl();
        $url = strtolower($url);

        //登录
        $this->noLoginUrls = array_map('strtolower', $this->noLoginUrls);
        if (in_array($url, $this->noLoginUrls)) {
            return;
        }

        //鉴权
        $this->noAuthUrls = array_map('strtolower', $this->noAuthUrls);
        if (in_array($url, $this->noAuthUrls)) {
            return;
        }

        $mobileService = new MobileService();
        if(!$mobileService->hasPermission($userId, $url)){
            throw new Exception('无权限');
        }
    }
}