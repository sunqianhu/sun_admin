<?php

namespace app\service\desktop;

use app\model\desktop\Permission as PermissionModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Permission
{
    /**
     * 得到树形权限
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreePermissions()
    {
        $permissionModels = PermissionModel::field('id, permission_id, name')
            ->order('sort', 'asc')
            ->select();
        $permissions = $permissionModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treePermissions = $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
        return $treePermissions;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $permissionModel = new PermissionModel();
        $permissionModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function edit($id, $data){
        $permissionModel = PermissionModel::find($id);
        if(empty($permissionModel)){
            throw new Exception('没有找到记录');
        }
        $permissionModel->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function delete($id){
        $permissionModel = PermissionModel::find($id);
        if(empty($permissionModel)){
            throw new Exception('没有找到记录');
        }
        if($this->hasChildrenPermission($id)){
            throw new Exception('存在子权限不能删除');
        }
        $permissionModel->delete();
    }

    /**
     * 是否有子权限
     * @param $id
     * @return void
     */
    public function hasChildrenPermission($id){
        $permissionModel = PermissionModel::where('permission_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($permissionModel)){
            return true;
        }
        return false;
    }
}