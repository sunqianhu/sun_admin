<?php

namespace app\service\mobile;

use app\model\mobile\PermissionModel;
use Sunqianhu\Helper\ArrayHandler;

class PermissionService
{
    /**
     * 得到树形权限
     * @return array
     */
    public function getTreePermission()
    {
        $permissionModels = PermissionModel::field('id, permission_id, name')
            ->order('sort', 'asc')
            ->select();
        $permissions = $permissionModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
    }

    /**
     * 得到带名称和key的树形权限
     * @return array
     */
    public function getNameKeyTreePermission()
    {
        $permissionModels = PermissionModel::field('id, permission_id, name, key')
            ->order('sort', 'asc')
            ->append(['name_key'])
            ->select();
        $permissions = $permissionModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
    }
}