<?php

namespace app\service;

use app\model\OperationLog as OperationLogModel;
use app\service\desktop\Session as SessionService;
use Exception;

class OperationLog
{
    /**
     * 添加
     * @return void
     */
    public function add($userId, $url, $ip)
    {
        if (empty($userId)) {
            throw new Exception('用户id不能为空');
        }
        $url = strtolower($url);
        $sessionService = new SessionService();

        $noSlashUrl = substr($url, 1);
        if (in_array($noSlashUrl, $sessionService->noLoginUrls)) {
            return;
        }
        if (in_array($noSlashUrl, $sessionService->noAuthUrls)) {
            return;
        }

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