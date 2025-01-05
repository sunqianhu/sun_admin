<?php

namespace app\service\user\mobile;

use app\model\mobile\PermissionModel;
use app\model\mobile\TokenModel;
use app\service\User as SystemUser;

class User
{
    /**
     * 得到接口集合
     * @param $userId
     * @return array
     */
    public function getApis($userId){
        $user = new SystemUser();
        $roleIds = $user->getRoleIds($userId);
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
        $allApis = array_unique($allApis);
        return $allApis;
    }

    /**
     * 是否有权限
     * @param $userId
     * @param $api
     * @return false|void
     */
    public function hasApiPermission($userId, $api){
        $apis = $this->getApis($userId);
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
     * 得到权限key集合
     * @param $userId
     * @return void
     */
    public function getPermissionKeys($userId){
        $user = new SystemUser();
        $roleIds = $user->getRoleIds($userId);
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
        TokenModel::where('user_id', '=', $id)->delete();
    }
}