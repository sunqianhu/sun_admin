<?php

namespace app\service;

use app\model\RoleDesktopMenuModel;

class RoleDesktopMenuService extends CurdService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RoleDesktopMenuModel::class);
    }
}