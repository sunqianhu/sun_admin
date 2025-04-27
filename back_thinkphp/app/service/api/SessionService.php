<?php

namespace app\service\api;

use app\model\api\SessionModel;
use app\model\ConfigModel;
use app\model\LoginLogModel;
use app\model\UserModel;
use app\service\CrudService;
use app\service\JwtService;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class SessionService
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public int $expire = 60 * 60 * 24 * 365; //有效期

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
        $sessionCrudService = new CrudService(SessionModel::class);
        return $sessionCrudService->insert($data);
    }

    /**
     * 删除会话
     * @param $id
     * @throws Exception
     */
    public function deleteSession($id)
    {
        $sessionCrudService = new CrudService(SessionModel::class);
        $sessionCrudService->delete($id);
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
            throw new Exception('账号或密码错误');
        }
        if ($userModel->status == 0) {
            throw new Exception('账号已停用');
        }

        $jwtService = new JwtService();
        $token = $jwtService->generateToken($userModel->id);
        $sessionId = $this->createSession($userModel->id, $token);

        //登录日志
        $loginLogCrudService = new CrudService(LoginLogModel::class);
        $data = [
            'user_id' => $userModel->id,
            'ip' => $ip,
            'time' => time()
        ];
        $loginLogCrudService->insert($data);

        //用户表
        $userModel->last_login_time = time();
        $userModel->last_login_ip = $ip;
        $userModel->save();

        return $sessionId;
    }

    /**
     * 退出登录
     * @param $id
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
        $configCrudService = new CrudService(ConfigModel::class);
        $deniedIpString = $configCrudService->selectValue(1, 'denied_ip_string');
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
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
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

        $sessionCrudService = new CrudService(SessionModel::class);
        $session = $sessionCrudService->selectRowByField('token', $token);
        if (empty($session)) {
            throw new Exception('未登录');
        }
        if ($session['expires_in'] < time()) {
            throw new Exception('登录已过期');
        }
        if ($session['user_id'] != $userId) {
            throw new Exception('登录凭证错误');
        }

        return $session['id'];
    }

    /**
     * 得到token
     * @param $id
     * @return string
     * @throws Exception
     */
    public function getToken($id)
    {
        $sessionCrudService = new CrudService(SessionModel::class);
        $session = $sessionCrudService->selectRow($id);
        if(empty($session)){
            throw new Exception('没有找到会话记录');
        }
        return $session['token'];
    }

    /**
     * 得到用户id
     * @param $id
     * @return int
     * @throws Exception
     */
    public function getUserId($id)
    {
        $sessionCrudService = new CrudService(SessionModel::class);
        $session = $sessionCrudService->selectRow($id);
        if(empty($session)){
            throw new Exception('没有找到会话记录');
        }
        return $session['user_id'];
    }

    /**
     * 得到部门id
     * @param $id
     * @return int
     * @throws Exception
     */
    public function getDepartmentId($id)
    {
        $userId = $this->getUserId($id);
        $userCrudService = new CrudService(UserModel::class);
        $user = $userCrudService->selectRow($userId);
        if(empty($user)){
            throw new Exception('没有找到用户记录');
        }
        return $user['department_id'];
    }
}