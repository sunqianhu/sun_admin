<?php

namespace app\service;

use app\model\UserRoleModel;
use Exception;

class UserRole extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(UserRoleModel::class);
    }

}