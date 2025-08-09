<?php

namespace app\service\desktop;

use app\model\desktop\PermissionModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class PermissionService
{
    /**
     * 得到子权限id
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllPermissionIds($id){
        $permissionModels = PermissionModel::field('id')
            ->where('permission_id', $id)
            ->select();
        $ids = [];
        foreach($permissionModels as $permissionModel){
            $ids[] = $permissionModel->id;
            $ids = array_merge($ids, $this->getAllPermissionIds($permissionModel->id));
        }
        return $ids;
    }

    /**
     * 得到树形权限
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreePermission($id)
    {
        $ids = $this->getAllPermissionIds($id);
        $ids[] = $id;

        $permissionModels = PermissionModel::field('id, permission_id, name, key')
            ->whereIn('id', $ids)
            ->order('sort', 'asc')
            ->select();
        $permissions = $permissionModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
    }

    /**
     * 得到是否存在子权限
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getExistPermissions($id){
        $permissionModel = PermissionModel::field('id')
            ->where('permission_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($permissionModel)){
            return true;
        }
        return false;
    }
}