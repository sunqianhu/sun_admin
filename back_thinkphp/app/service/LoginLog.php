<?php

namespace app\service;

use app\model\LoginLogModel;

class LoginLog extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(LoginLogModel::class);
    }

    /**
     * 添加
     * @param $userId
     * @param $ip
     * @return void
     */
    public function add($userId, $ip){
        $data = [
            'user_id' => $userId,
            'time' => time(),
            'ip' => $ip
        ];
        $loginLogModel = new LoginLogModel();
        $loginLogModel->save($data);
    }
}