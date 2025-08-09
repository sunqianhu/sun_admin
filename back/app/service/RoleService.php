<?php

namespace app\service;

use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RoleService
{
    /**
     * 更新桌面端权限关联
     * @param $id
     * @param $permissionIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateDesktopPermissionRelation($id, $permissionIds)
    {
        Db::startTrans();
        try {
            $roleDesktopPermissionModels = RoleDesktopPermissionModel::where('role_id', $id)->select();
            $roleDesktopPermissionModels->delete();

            if (!empty($permissionIds)) {
                foreach ($permissionIds as $permissionId) {
                    $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                    $roleDesktopPermissionModel->save([
                        'role_id' => $id,
                        'permission_id' => $permissionId
                    ]);
                }
            }
            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 更新桌面端菜单关联
     * @param $id
     * @param $menuIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateDesktopMenuRelation($id, $menuIds)
    {
        Db::startTrans();
        try{
            $roleDesktopMenuModels = RoleDesktopMenuModel::where('role_id', $id)->select();
            $roleDesktopMenuModels->delete();

            if (!empty($menuIds)) {
                foreach ($menuIds as $menuId) {
                    $roleDesktopMenuModel = new RoleDesktopMenuModel();
                    $roleDesktopMenuModel->save([
                        'role_id' => $id,
                        'menu_id' => $menuId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 更新桌面端路由关联
     * @param $id
     * @param $routeIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateDesktopRouteRelation($id, $routeIds)
    {
        Db::startTrans();
        try{
            $roleDesktopRouteModels = RoleDesktopRouteModel::where('role_id', $id)->select();
            $roleDesktopRouteModels->delete();

            if (!empty($routeIds)) {
                foreach ($routeIds as $routeId) {
                    $roleDesktopRouteModel = new RoleDesktopRouteModel();
                    $roleDesktopRouteModel->save([
                        'role_id' => $id,
                        'route_id' => $routeId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 更新移动端权限关联
     * @param $id
     * @param $permissionIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateMobilePermissionRelation($id, $permissionIds)
    {
        Db::startTrans();
        try{
            $roleMobilePermissionModels = RoleMobilePermissionModel::where('role_id', $id)->select();
            $roleMobilePermissionModels->delete();

            if (!empty($permissionIds)) {
                foreach ($permissionIds as $permissionId) {
                    $roleMobilePermissionModel = new RoleMobilePermissionModel();
                    $roleMobilePermissionModel->save([
                        'role_id' => $id,
                        'permission_id' => $permissionId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }
}