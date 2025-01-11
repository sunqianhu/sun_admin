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
}