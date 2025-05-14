<?php

namespace app\service\desktop;

use app\model\desktop\MenuModel;
use app\model\desktop\PermissionModel;
use app\model\desktop\RouteModel;
use app\model\desktop\SessionModel;
use app\service\CrudService;
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
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($id);
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
     * @param $id
     * @param $api
     * @return bool
     */
    public function hasApiPermission($id, $api){
        $apis = $this->getApis($id);
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
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($id);
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
     * 得到树形菜单
     * @param $id
     * @return array
     */
    public function getTreeMenu($id){
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($id);
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
        $sessionCrudService = new CrudService(SessionModel::class);
        $sessionCrudService->deleteByField('user_id', $id);
    }
}