<?php

namespace app\service;

use app\model\RoleDesktopPermissionModel;

class RoleDesktopPermission extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RoleDesktopPermissionModel::class);
    }
}