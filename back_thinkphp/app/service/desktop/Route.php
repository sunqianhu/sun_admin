<?php

namespace app\service\desktop;

use app\service\User as UserService;
use Sunqianhu\Helper\ArrayHandler;

class Route
{
    /**
     * 得到用户的路由
     * @param $userId
     * @return array
     */
    public function getRoutes($userId)
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