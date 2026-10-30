<?php

namespace app\helper;

use app\model\PermissionModel;
use app\model\RolePermissionModel;
use Exception;
use Sunqianhu\Helper\Arr;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class PermissionHelper
{
    /**
     * 添加权限
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add(array $data)
    {
        $data['permission_id'] = (int) ($data['permission_id'] ?? 0);
        $permissionModel = new PermissionModel();
        $permissionModel->save($data);
        return $permissionModel->id;
    }

    /**
     * 修改权限
     * @param array $data
     * @throws Exception
     */
    public function edit(array $data)
    {
        $data['permission_id'] = (int) ($data['permission_id'] ?? 0);
        $permissionModel = PermissionModel::find($data['id']);
        if (empty($permissionModel)) {
            throw new Exception('没有找到权限记录');
        }
        $permissionModel->save($data);
    }

    /**
     * 删除权限及角色关联
     * @param $id
     * @throws Exception
     */
    public function delete($id)
    {
        $permissionModel = PermissionModel::find($id);
        if (empty($permissionModel)) {
            throw new Exception('没有找到权限记录');
        }
        $permissionModel->delete();
    }

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

        $arr = new Arr();
        return $arr->toTree($permissions, 'id', 'permission_id', 'children');
    }

    /**
     * 是否存在子权限
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
