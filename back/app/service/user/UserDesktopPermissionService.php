<?php

namespace app\service\user;

use app\model\desktop\PermissionModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserDesktopPermissionService
{
    /**
     * 得到接口列表
     * @param $userId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getApis($userId){
        $userRoleService = new UserRoleService();
        $roleIds = $userRoleService->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $permissionModels = PermissionModel::alias('p')
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.api_string')
            ->whereIn('rdp.role_id', $roleIds)
            ->where('p.api_string', '<>', '')
            ->group('p.id')
            ->append(['apis'])
            ->select();
        if ($permissionModels->isEmpty()) {
            return [];
        }
        $allApis = [];
        foreach ($permissionModels as $permissionModel) {
            $apis = $permissionModel->apis;
            $allApis = array_merge($allApis, $apis);
        }
        return array_unique($allApis);
    }

    /**
     * 是否有权限
     * @param $userId
     * @param $api
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function hasPermissionByApi($userId, $api){
        $apis = $this->getApis($userId);
        if(empty($apis)){
            return false;
        }

        $api = ltrim($api, '/');
        $api = strtolower($api);
        $apis = array_map('strtolower', $apis);
        if (in_array($api, $apis, true)) {
            return true;
        }
        return false;
    }

    /**
     * 得到权限key列表
      * @param $userId
     * @return array
     */
    public function getPermissionKeys($userId){
        $userRoleService = new UserRoleService();
        $roleIds = $userRoleService->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $keys = PermissionModel::alias('p')
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.key')
            ->where('rdp.role_id', 'in', $roleIds)
            ->orderRaw('ANY_VALUE(p.sort) asc')
            ->group('p.key')
            ->column('p.key');
        return array_unique($keys);
    }

    /**
     * 是否有权限
     * @param $userId
     * @param $key
     * @return bool
     */
    public function hasPermission($userId, $key){
        $keys = $this->getPermissionKeys($userId);
        if(in_array($key, $keys)){
            return true;
        }
        return false;
    }
}