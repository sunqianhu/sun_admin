<?php

namespace app\service;

use app\model\OperationLogModel;
use Exception;

class OperationLogService extends CurdService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(OperationLogModel::class);
    }
}