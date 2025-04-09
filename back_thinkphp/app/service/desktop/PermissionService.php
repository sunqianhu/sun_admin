<?php

namespace app\service\desktop;

use app\model\desktop\PermissionModel;
use Sunqianhu\Helper\ArrayHandler;

class PermissionService
{
    /**
     * 得到树形权限
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreePermission()
    {
        $permissionModels = PermissionModel::field('id, permission_id, name, key')
            ->order('sort', 'asc')
            ->select();
        $permissions = $permissionModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
    }

    /**
     * 得到名称和key的树形权限
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
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

    /**
     * 是否有子权限
     * @param $id
     * @return bool
     */
    public function hasChildrenPermission($id){
        $permission = PermissionModel::field('id')
            ->where('permission_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($permission)){
            return true;
        }
        return false;
    }
}