<?php

namespace app\service\mobile;

use app\model\mobile\PermissionModel;
use app\model\mobile\TokenModel;
use app\service\CrudService;
use app\service\UserService;

class MobileUserService
{
    /**
     * 得到接口列表
     * @param $id
     * @return array
     */
    public function getApis($id){
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($id);
        if(empty($roleIds)){
            return [];
        }

        $permissionModels = PermissionModel::alias('p')
            ->join('role_mobile_permission rmp', 'p.id = rmp.permission_id')
            ->field('p.api_string')
            ->where('rmp.role_id', 'in', $roleIds)
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
     * @param $id
     * @param $api
     * @return bool
     */
    public function hasApiPermission($id, $api){
        $apis = $this->getApis($id);
        if(empty($apis)){
            return false;
        }

        $api = strtolower($api);
        $apis = array_map('strtolower', $apis);
        foreach($apis as $forApi){
            if($forApi === $api){
                return true;
            }
        }

        return false;
    }

    /**
     * 得到权限key列表
     * @param $id
     * @return array
     */
    public function getPermissionKeys($id){
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($id);
        if(empty($roleIds)){
            return [];
        }

        $keys = PermissionModel::alias('p')
            ->join('role_mobile_permission rmp', 'p.id = rmp.permission_id')
            ->field('p.key')
            ->where('rmp.role_id', 'in', $roleIds)
            ->order('p.sort', 'asc')
            ->group('key')
            ->column('key');
        return $keys;
    }

    /**
     * 下线
     * @param $id
     * @return void
     */
    public function offLine($id){
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenCrudService->fieldDelete('user_id', $id);
    }
}