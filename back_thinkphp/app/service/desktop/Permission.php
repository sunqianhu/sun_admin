<?php

namespace app\service\desktop;

use app\model\desktop\Permission as PermissionModel;
use app\model\User as UserModel;
use app\service\User as UserService;
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

    /**
     * 得到权限集合
     * @return mixed
     */
    public function getPermissionsByUserId($userId)
    {
        $permissions = [];
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
        if (empty($roleIds)) {
            return $permissions;
        }

        //权限
        $permissionModels = PermissionModel::alias('p')
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.key')
            ->where('rdp.role_id', 'in', $roleIds)
            ->order('p.sort', 'asc')
            ->group('p.id')
            ->select();
        if ($permissionModels->isEmpty()) {
            return $permissions;
        }

        foreach ($permissionModels as $permissionModel) {
            $permissions[] = $permissionModel->key;
        }
        if(!empty($permissions)){
            $permissions = array_unique($permissions);
        }

        return $permissions;
    }

    /**
     * 通过桌面端权限key得到用户ids
     * @param $permissionKey
     * @param $departmentIds
     * @return array
     */
    public function getIdsByDesktopPermissionKey($permissionKey, $departmentIds = []){
        $userIds = [];

        //角色id
        $roleIds = PermissionModel::alias('m')
            ->leftJoin('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->where('p.key', $permissionKey)
            ->group('rdp.role_id')
            ->column('rdp.role_id');
        if(empty($roleIds)){
            return $userIds;
        }

        //用户id
        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->where('ur.role_id', 'in', $roleIds)
            ->where('u.status_id', 1)
            ->group('u.id');
        if(!empty($departmentIds)){
            $query = $query->where('u.department_id', 'in', $departmentIds);
        }
        $userIds = $query->column('u.id');

        return $userIds;
    }
}