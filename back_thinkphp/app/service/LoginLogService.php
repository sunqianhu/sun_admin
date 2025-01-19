<?php

namespace app\service;

use app\model\LoginLogModel;

class LoginLogService extends CurdService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(LoginLogModel::class);
    }
}