<?php

namespace app\service;

use app\model\UserRoleModel;
use Exception;

class UserRoleService extends CurdService
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