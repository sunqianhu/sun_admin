<?php

namespace app\service\desktop;

use app\model\desktop\Route as RouteModel;
use app\service\User as UserService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Route
{
    /**
     * 得到路由集合
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoutes()
    {
        $routeModels = RouteModel::order('sort', 'asc')
            ->select();
        $routes = $routeModels->toArray();

        return $routes;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $routeModel = new RouteModel();
        $routeModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit($id, $data){
        $routeModel = RouteModel::find($id);
        if(empty($routeModel)){
            throw new Exception('没有找到记录');
        }
        $routeModel->save($data);
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
        $routeModel = RouteModel::find($id);
        if(empty($routeModel)){
            throw new Exception('没有找到记录');
        }
        if($this->hasChildrenRoute($id)){
            throw new Exception('存在子菜单不能删除');
        }
        $routeModel->delete();
    }

    /**
     * 得到路由集合
     * @param $userId
     * @return array
     */
    public function getRoutesByUserId($userId)
    {
        $routes = [];
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
        if (empty($roleIds)) {
            return $routes;
        }

        //页面
        $permissionModels = PermissionModel::alias('m')
            ->join('role_desktop_permission rdp', 'p.id = rdp.permission_id')
            ->field('p.id,p.permission_id,p.type_id,p.name,p.path,p.key,p.component,p.keep_alive,p.layout')
            ->where('p.type_id', 'in', '1,2')
            ->where('rdp.role_id', 'in', $roleIds)
            ->order('p.sort', 'asc')
            ->group('p.id')
            ->select();
        if ($permissionModels->isEmpty()) {
            return $routes;
        }

        $permissions = $permissionModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treePermissions = $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
        $permissionService = new PermissionService();
        $mainFirstPageId = $permissionService->getMainFirstPageId($treePermissions);
        $blankFirstPageId = $permissionService->getBlankFirstPageId($treePermissions);

        foreach ($permissionModels as $permissionModel) {
            if (
                $permissionModel->type_id != 2 ||
                $permissionModel->path === '' ||
                $permissionModel->name === '' ||
                $permissionModel->component === ''
            ) {
                continue;
            }

            //父页面跳转
            $parentRedirect = '';
            if ($permissionModel->id == $mainFirstPageId) {
                $parentRedirect = 'main';
            }
            if ($permissionModel->id == $blankFirstPageId) {
                $parentRedirect = 'blank';
            }

            $route = [];
            $route['path'] = $permissionModel->path;
            $route['name'] = $permissionModel->key;
            $route['component'] = $permissionModel->component;
            $route['layout'] = $permissionModel->layout;
            $route['parent_redirect'] = $parentRedirect;
            $route['meta']['name'] = $permissionModel->name;
            $route['meta']['keep_alive'] = $permissionModel->keep_alive == 1;
            $routes[] = $route;
        }

        return $routes;
    }
}