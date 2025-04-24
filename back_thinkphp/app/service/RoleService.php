<?php

namespace app\service;

use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;

class RoleService
{
    /**
     * 更新桌面端权限关联
     * @param $id
     * @param $permissionIds
     * @return void
     */
    public function updateDesktopPermissionRelation($id, $permissionIds)
    {
        $roleDesktopPermissionCrudService = new CrudService(RoleDesktopPermissionModel::class);
        $roleDesktopPermissionCrudService->deleteByField('role_id', $id);
        if (!empty($permissionIds)) {
            foreach ($permissionIds as $permissionId) {
                $roleDesktopPermissionCrudService->insert([
                    'role_id' => $id,
                    'permission_id' => $permissionId
                ]);
            }
        }
    }

    /**
     * 更新桌面端菜单关联
     * @param $id
     * @param $menuIds
     * @return void
     */
    public function updateDesktopMenuRelation($id, $menuIds)
    {
        $roleDesktopMenuCrudService = new CrudService(RoleDesktopMenuModel::class);
        $roleDesktopMenuCrudService->deleteByField('role_id', $id);
        if (!empty($menuIds)) {
            foreach ($menuIds as $menuId) {
                $roleDesktopMenuCrudService->insert([
                    'role_id' => $id,
                    'menu_id' => $menuId
                ]);
            }
        }
    }

    /**
     * 更新桌面端路由关联
     * @param $id
     * @param $routeIds
     * @return void
     */
    public function updateDesktopRouteRelation($id, $routeIds)
    {
        $roleDesktopRouteCrudService = new CrudService(RoleDesktopRouteModel::class);
        $roleDesktopRouteCrudService->deleteByField('role_id', $id);
        if (!empty($routeIds)) {
            foreach ($routeIds as $routeId) {
                $roleDesktopRouteCrudService->insert([
                    'role_id' => $id,
                    'route_id' => $routeId
                ]);
            }
        }
    }

    /**
     * 更新移动端权限关联
     * @param $id
     * @param $permissionIds
     * @return void
     */
    public function updateMobilePermissionRelation($id, $permissionIds)
    {
        $roleMobilePermissionCrudService = new CrudService(RoleMobilePermissionModel::class);
        $roleMobilePermissionCrudService->deleteByField('role_id', $id);
        if (!empty($permissionIds)) {
            foreach ($permissionIds as $permissionId) {
                $roleMobilePermissionCrudService->insert([
                    'role_id' => $id,
                    'permission_id' => $permissionId
                ]);
            }
        }
    }
}