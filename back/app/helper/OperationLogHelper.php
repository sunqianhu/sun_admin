<?php

namespace app\helper;

use app\model\OperationLogModel;
use Exception;

class OperationLogHelper
{
    /**
     * 添加操作日志
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add(array $data)
    {
        $data['time'] = $data['time'] ?? time();
        $operationLogModel = new OperationLogModel();
        $operationLogModel->save($data);

        return $operationLogModel->id;
    }
}
