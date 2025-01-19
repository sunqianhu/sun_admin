<?php

namespace app\service\desktop;

use app\model\desktop\MenuModel;
use app\model\desktop\PermissionModel;
use app\model\desktop\RouteModel;
use app\service\UserService;
use Sunqianhu\Helper\ArrayHandler;

class DesktopUserService
{
    /**
     * 得到接口列表
     * @param $id
     * @return array
     */
    public function getApis($id){
        $user = new UserService();
        $roleIds = $user->getRoleIds($id);
        if(empty($roleIds)){
            return [];
        }

        $permissions = PermissionModel::alias('p')
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.api_string')
            ->whereIn('rdp.role_id', $roleIds)
            ->where('p.api_string', '<>', '')
            ->group('p.id')
            ->append(['apis'])
            ->select();
        if ($permissions->isEmpty()) {
            return [];
        }
        $allApis = [];
        foreach ($permissions as $permission) {
            $apis = $permission->apis;
            $allApis = array_merge($allApis, $apis);
        }
        return array_unique($allApis);
    }

    /**
     * 是否有权限
     * @param $id
     * @param $api
     * @return false|void
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
     * @return void
     */
    public function getPermissionKeys($id){
        $user = new UserService();
        $roleIds = $user->getRoleIds($id);
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
        return array_unique($keys);
    }

    /**
     * 是否有权限
     * @param $id
     * @param $key
     * @return bool
     */
    public function hasPermission($id, $key){
        $keys = $this->getPermissionKeys($id);
        if(in_array($key, $keys)){
            return true;
        }
        return false;
    }

    /**
     * 得到路由
     * @param $id
     * @return array
     */
    public function getRoutes($id){
        $user = new UserService();
        $roleIds = $user->getRoleIds($id);
        if(empty($roleIds)){
            return [];
        }

        $routes = RouteModel::alias('r')
            ->join('role_desktop_route rdr', 'r.id = rdr.route_id')
            ->field('r.*')
            ->where('rdr.role_id', 'in', $roleIds)
            ->order('r.sort', 'asc')
            ->select();
        $routeArrs = [];
        foreach($routes as $route){
            $route = [
                'path'=>$route->path,
                'name'=>$route->key,
                'component_path'=>$route->component_path,
                'layout'=>$route->layout,
                'meta'=>[
                    'name'=>$route->name,
                    'keep_alive'=>$route->keep_alive
                ]
            ];
            $routeArrs[] = $route;
        }
        return $routeArrs;
    }

    /**
     * 得到树形菜单
     * @param $id
     * @return array
     */
    public function getTreeMenu($id){
        $user = new UserService();
        $roleIds = $user->getRoleIds($id);
        if(empty($roleIds)){
            return [];
        }

        $menus = MenuModel::alias('m')
            ->field('m.*')
            ->join('role_desktop_menu rdm', 'm.id = rdm.menu_id')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->select();
        $menus = $menus->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
    }

    /**
     * 下线
     * @param $id
     * @return void
     */
    public function offLine($id){
        $token = new TokenService();
        $token->fieldDelete('user_id', $id);
    }
}