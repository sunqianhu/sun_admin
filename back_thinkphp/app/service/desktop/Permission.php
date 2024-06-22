<?php

namespace app\service\desktop;

use app\model\desktop\Module as ModuleModel;
use app\model\User as UserModel;
use app\service\User as UserService;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class Permission
{
    /**
     * 得到树形模块
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeModules()
    {
        $moduleModels = ModuleModel::field('id, module_id, name')
            ->order('sort', 'asc')
            ->select();
        $modules = $moduleModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');
        return $treeModules;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $moduleModel = new ModuleModel();
        $moduleModel->save($data);
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
        $moduleModel = ModuleModel::find($id);
        if(empty($moduleModel)){
            throw new Exception('没有找到记录');
        }
        $moduleModel->save($data);
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
        $moduleModel = ModuleModel::find($id);
        if(empty($moduleModel)){
            throw new Exception('没有找到记录');
        }
        $moduleModel->delete();
    }

    /**
     * 得到主布局第一个页面模块id
     * @param $treeModules
     * @return int|mixed
     */
    public function getMainFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "main" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getMainFirstPageId($treeModule['children']);
        }

        return 0;
    }

    /**
     * 得到空白布局第一个页面模块id
     * @param $treeModules
     * @return int|mixed
     */
    public function getBlankFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "blank" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getBlankFirstPageId($treeModule['children']);
        }

        return 0;
    }

    /**
     * 获取用户的权限
     * @return mixed
     */
    public function getPermissions($userId)
    {
        $permissions = [];
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
        if (empty($roleIds)) {
            return $permissions;
        }

        //模块
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
     * 通过桌面端模块key得到用户ids
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