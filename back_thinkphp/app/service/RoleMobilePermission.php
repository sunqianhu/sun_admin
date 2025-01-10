<?php

namespace app\service;

use app\model\RoleMobilePermissionModel;

class RoleMobilePermission extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RoleMobilePermissionModel::class);
    }
}