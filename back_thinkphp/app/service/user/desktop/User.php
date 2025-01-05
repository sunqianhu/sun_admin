<?php

namespace app\service\user\desktop;

use app\model\desktop\MenuModel;
use app\model\desktop\PermissionModel;
use app\model\desktop\RouteModel;
use app\model\desktop\TokenModel;
use app\service\User as SystemUser;
use Sunqianhu\Helper\ArrayHandler;

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
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.api_string')
            ->where('rdp.role_id', 'in', $roleIds)
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
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.key')
            ->where('rdp.role_id', 'in', $roleIds)
            ->order('p.sort', 'asc')
            ->group('key')
            ->column('key');
        return $keys;
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

    /**
     * 得到路由
     * @param $userId
     * @return array
     */
    public function getRoutes($userId){
        $user = new SystemUser();
        $roleIds = $user->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $routeModels = RouteModel::alias('r')
            ->join('role_desktop_route rdr', 'r.id = rdr.route_id')
            ->field('r.*')
            ->where('rdr.role_id', 'in', $roleIds)
            ->order('r.sort', 'asc')
            ->select();
        $routes = [];
        foreach($routeModels as $routeModel){
            $route = [
                'path'=>$routeModel->path,
                'name'=>$routeModel->key,
                'component_path'=>$routeModel->component_path,
                'layout'=>$routeModel->layout,
                'meta'=>[
                    'name'=>$routeModel->name,
                    'keep_alive'=>$routeModel->keep_alive
                ]
            ];
            $routes[] = $route;
        }
        return $routes;
    }

    /**
     * 得到菜单
     * @param $userId
     * @return array
     */
    public function getMenus($userId){
        $user = new SystemUser();
        $roleIds = $user->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $menuModels = MenuModel::alias('m')
            ->field('m.*')
            ->join('role_desktop_menu rdm', 'm.id = rdm.menu_id')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
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