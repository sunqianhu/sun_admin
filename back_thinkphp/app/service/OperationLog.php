<?php

namespace app\service;

use app\model\OperationLogModel;
use Exception;

class OperationLog
{
    /**
     * 添加
     * @return void
     * @throws Exception
     */
    public function add($userId, $url, $ip)
    {
        if (empty($userId)) {
            throw new Exception('用户id不能为空');
        }
        $url = strtolower($url);
        $data = [
            'user_id' => $userId,
            'time' => time(),
            'ip' => $ip,
            'url' => $url
        ];
        $operationLogModel = new OperationLogModel();
        $operationLogModel->save($data);
    }
}