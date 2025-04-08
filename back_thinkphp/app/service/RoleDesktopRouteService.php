<?php

namespace app\service;

use app\model\RoleDesktopRouteModel;

class RoleDesktopRouteService extends CrudService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RoleDesktopRouteModel::class);
    }
}