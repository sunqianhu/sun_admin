<?php

namespace app\service;

use app\model\LoginLog as LoginLogModel;

class LoginLog
{
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