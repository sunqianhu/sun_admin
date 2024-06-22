<?php

namespace app\service\desktop;

use app\entity\desktop\Session as SessionEntity;
use app\entity\User as UserEntity;
use app\model\LoginLog as LoginLogModel;
use app\model\User as UserModel;
use app\service\desktop\session\Jwt;
use Exception;

class Session
{
    /**
     * 登录
     * @param $account
     * @param $password
     * @param $ip
     * @return SessionEntity
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function login($account, $password, $ip)
    {
        $userModel = UserModel::field('id,department_id,status_id,name,phone,avatar')
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
        $data = [
            'user_id' => $userModel->id,
            'time' => time(),
            'ip' => $ip
        ];
        $loginLogModel = new LoginLogModel();
        $loginLogModel->save($data);

        //用户表
        $userModel->login_time = time();
        $userModel->login_ip = $ip;
        $userModel->save();

        $sessionEntity = new SessionEntity();
        $sessionEntity->userId = $userModel->id;
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
}