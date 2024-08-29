<?php

namespace app\service\user;

use app\model\mobile\Permission as PermissionModel;
use app\model\mobile\Token as TokenModel;
use app\service\User as UserService;

class Mobile
{
    /**
     * 得到接口集合
     * @param $userId
     * @return array
     */
    public function getApis($userId){
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
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
     * @param $url
     * @return false|void
     */
    public function hasPermissionByUrl($userId, $url){
        $apis = $this->getApis($userId);
        if(empty($apis)){
            return false;
        }

        $url = strtolower($url);
        $apis = array_map('strtolower', $apis);
        foreach($apis as $api){
            if($api === $url){
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
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
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