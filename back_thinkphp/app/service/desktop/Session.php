<?php

namespace app\service\desktop;

use app\entity\desktop\Session as SessionEntity;
use app\entity\User as UserEntity;
use app\model\User as UserModel;
use app\service\desktop\session\Jwt;
use app\service\LoginLog as LoginLogService;
use app\service\user\Desktop as DesktopService;
use Exception;

class Session
{
    /**
     * @var string[] 不登录网址
     */
    public $noLoginUrls = [
        'desktop/Login/login',
        'desktop/Test/index'
    ];

    /**
     * @var string[] 不鉴权网址
     */
    public $noAuthUrls = [
        'desktop/Frame/getRoutes',
        'desktop/Frame/getPermissions',
        'desktop/Main/getMenus',
        'desktop/Main/getAvatar',
        'desktop/Main/getWatermark',
        'desktop/Main/logout',
        'desktop/main.user.Detail/getUser',
        'desktop/main.user.EditAvatar/init',
        'desktop/main.user.EditAvatar/save',
        'desktop/main.user.EditPassword/save',
        'desktop/main.Message/readAll',
        'desktop/main.Message/getNoReads',
        'desktop/uploadFile/upload'
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
     * 鉴权
     * @return void
     * @throws Exception
     */
    function auth($request)
    {
        $appName = app('http')->getName();
        $controller = $request->controller();
        $action = $request->action();
        $url = $appName . '/' . $controller . '/' . $action;
        $url = strtolower($url);
        $token = $request->header('token', '');

        //登录
        $this->noLoginUrls = array_map('strtolower', $this->noLoginUrls);
        if (in_array($url, $this->noLoginUrls)) {
            try{
                $jwt = new Jwt();
                return $jwt->resolverToken($token);
            }catch (Exception $exception){
                return;
            }
        }

        if ($token === '') {
            throw new Exception('未获取到token');
        }
        $jwt = new Jwt();
        $sessionEntity = $jwt->resolverToken($token);
        $userEntity = $sessionEntity->user;

        $this->noAuthUrls = array_map('strtolower', $this->noAuthUrls);
        if (in_array($url, $this->noAuthUrls)) {
            return $sessionEntity;
        }

        $desktopService = new DesktopService();
        if(!$desktopService->hasPermission($userEntity->id, $url)){
            throw new Exception('无权限');
        }

        return $sessionEntity;
    }
}