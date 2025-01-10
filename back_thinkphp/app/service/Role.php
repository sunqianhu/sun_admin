<?php

namespace app\service;

use app\model\RoleModel;
use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;
use app\model\UserRoleModel;
use Exception;
use think\facade\Db;

class Role extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RoleModel::class);
    }

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
                    $roleDesktopPermission = new RoleDesktopPermissionModel();
                    $roleDesktopPermission->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            if (!empty($data['desktop_menu_ids'])) {
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenu = new RoleDesktopMenuModel();
                    $roleDesktopMenu->save([
                        'role_id' => $roleModel->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            if (!empty($data['desktop_route_ids'])) {
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRoute = new RoleDesktopRouteModel();
                    $roleDesktopRoute->save([
                        'role_id' => $roleModel->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            if (!empty($data['mobile_permission_ids'])) {
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermission = new RoleMobilePermissionModel();
                    $roleMobilePermission->save([
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
                    $roleDesktopPermission = new RoleDesktopPermissionModel();
                    $roleDesktopPermission->save([
                        'role_id' => $roleModel->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            RoleDesktopMenuModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['desktop_menu_ids'])) {
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenu = new RoleDesktopMenuModel();
                    $roleDesktopMenu->save([
                        'role_id' => $roleModel->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            RoleDesktopRouteModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['desktop_route_ids'])) {
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRoute = new RoleDesktopRouteModel();
                    $roleDesktopRoute->save([
                        'role_id' => $roleModel->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            RoleMobilePermissionModel::where('role_id', $roleModel->id)->delete();
            if (!empty($data['mobile_permission_ids'])) {
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermission = new RoleMobilePermissionModel();
                    $roleMobilePermission->save([
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
            throw new Exception('没有找到角色记录');
        }

        UserRoleModel::where('role_id', $roleModel->id)->delete();
        $roleModel->delete();
    }
}