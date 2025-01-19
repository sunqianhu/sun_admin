<?php

namespace app\service;

use app\model\RoleDesktopPermissionModel;

class RoleDesktopPermissionService extends CurdService
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