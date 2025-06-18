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
        $roleDesktopPermissionCrud = new Crud(RoleDesktopPermissionModel::class);
        $roleDesktopPermissionCrud->deleteByField('role_id', $id);
        if (!empty($permissionIds)) {
            foreach ($permissionIds as $permissionId) {
                $roleDesktopPermissionCrud->insert([
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
        $roleDesktopMenuCrud = new Crud(RoleDesktopMenuModel::class);
        $roleDesktopMenuCrud->deleteByField('role_id', $id);
        if (!empty($menuIds)) {
            foreach ($menuIds as $menuId) {
                $roleDesktopMenuCrud->insert([
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
        $roleDesktopRouteCrud = new Crud(RoleDesktopRouteModel::class);
        $roleDesktopRouteCrud->deleteByField('role_id', $id);
        if (!empty($routeIds)) {
            foreach ($routeIds as $routeId) {
                $roleDesktopRouteCrud->insert([
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
        $roleMobilePermissionCrud = new Crud(RoleMobilePermissionModel::class);
        $roleMobilePermissionCrud->deleteByField('role_id', $id);
        if (!empty($permissionIds)) {
            foreach ($permissionIds as $permissionId) {
                $roleMobilePermissionCrud->insert([
                    'role_id' => $id,
                    'permission_id' => $permissionId
                ]);
            }
        }
    }
}