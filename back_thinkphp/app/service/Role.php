<?php

namespace app\service;

use app\model\Role as RoleModel;
use app\model\RoleDesktopMenu as RoleDesktopMenuModel;
use app\model\RoleDesktopPermission as RoleDesktopPermissionModel;
use app\model\RoleDesktopRoute as RoleDesktopRouteModel;
use app\model\RoleMobilePermission as RoleMobilePermissionModel;
use app\model\UserRole as UserRoleModel;
use Exception;
use think\facade\Db;

class Role
{
    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        Db::startTrans();
        try {
            $roleModel = new RoleModel();
            $roleModel->save($data);

            if (!empty($data['desktop_permission_ids'])) {
                foreach ($data['desktop_permission_ids'] as $desktopPermissionId) {
                    $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                    $roleDesktopPermissionModel->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            if (!empty($data['desktop_menu_ids'])) {
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenuModel = new RoleDesktopMenuModel();
                    $roleDesktopMenuModel->save([
                        'role_id' => $roleModel->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            if (!empty($data['desktop_route_ids'])) {
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRouteModel = new RoleDesktopRouteModel();
                    $roleDesktopRouteModel->save([
                        'role_id' => $roleModel->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            if (!empty($data['mobile_permission_ids'])) {
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermissionModel = new RoleMobilePermissionModel();
                    $roleMobilePermissionModel->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $mobilePermissionId
                    ]);
                }
            }

            Db::commit();
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
            Db::rollback();
        }
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     */
    public function edit($id, $data)
    {
        Db::startTrans();
        try {
            $roleModel = RoleModel::find($id);
            if (empty($roleModel)) {
                throw new Exception('没有找到记录');
            }
            $roleModel->save($data);

            RoleDesktopPermissionModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['desktop_permission_ids'])) {
                foreach ($data['desktop_permission_ids'] as $desktopPermissionId) {
                    $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                    $roleDesktopPermissionModel->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            RoleDesktopMenuModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['desktop_menu_ids'])) {
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenuModel = new RoleDesktopMenuModel();
                    $roleDesktopMenuModel->save([
                        'role_id' => $roleModel->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            RoleDesktopRouteModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['desktop_route_ids'])) {
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRouteModel = new RoleDesktopRouteModel();
                    $roleDesktopRouteModel->save([
                        'role_id' => $roleModel->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            RoleMobilePermissionModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['mobile_permission_ids'])) {
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermissionModel = new RoleMobilePermissionModel();
                    $roleMobilePermissionModel->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $mobilePermissionId
                    ]);
                }
            }

            Db::commit();
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
            Db::rollback();
        }
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function delete($id)
    {
        $roleModel = RoleModel::find($id);
        if(empty($roleModel)){
            throw new Exception('没有找到记录');
        }

        UserRoleModel::where('role_id', $roleModel->id)->delete();
        $roleModel->delete();
    }
}