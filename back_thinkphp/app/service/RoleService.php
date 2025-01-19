<?php

namespace app\service;

use app\model\RoleModel;
use Exception;
use think\facade\Db;

class RoleService extends CurdService
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
     * @throws Exception
     */
    public function add($data)
    {
        Db::startTrans();
        try {
            $role = new RoleModel();
            $role->save($data);

            //桌面端权限
            if (!empty($data['desktop_permission_ids'])) {
                $roleDesktopPermission = new RoleDesktopPermissionService();
                foreach ($data['desktop_permission_ids'] as $desktopPermissionId) {
                    $roleDesktopPermission->add([
                        'role_id' => $role->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            //桌面端菜单
            if (!empty($data['desktop_menu_ids'])) {
                $roleDesktopMenu = new RoleDesktopMenuService();
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenu->add([
                        'role_id' => $role->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            //桌面端路由
            if (!empty($data['desktop_route_ids'])) {
                $roleDesktopRoute = new RoleDesktopRouteService();
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRoute->add([
                        'role_id' => $role->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            //移动端权限
            if (!empty($data['mobile_permission_ids'])) {
                $roleMobilePermission = new RoleMobilePermissionService();
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermission->add([
                        'role_id' => $role->id,
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
     * @throws Exception
     */
    public function edit($id, $data)
    {
        Db::startTrans();
        try {
            $role = RoleModel::find($id);
            if (empty($role)) {
                throw new Exception('没有找到记录');
            }
            $role->save($data);

            //桌面端权限
            if (isset($data['desktop_permission_ids'])) {
                $roleDesktopPermission = new RoleDesktopPermissionService();
                $roleDesktopPermission->fieldDelete('role_id', $role->id);
                foreach ($data['desktop_permission_ids'] as $desktopPermissionId) {
                    $roleDesktopPermission->add([
                        'role_id' => $role->id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            //桌面端菜单
            if (isset($data['desktop_menu_ids'])) {
                $roleDesktopMenu = new RoleDesktopMenuService();
                $roleDesktopMenu->fieldDelete('role_id', $role->id);
                foreach ($data['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenu->add([
                        'role_id' => $role->id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            //桌面端路由
            if (isset($data['desktop_route_ids'])) {
                $roleDesktopRoute = new RoleDesktopRouteService();
                $roleDesktopRoute->fieldDelete('role_id', $role->id);
                foreach ($data['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRoute->add([
                        'role_id' => $role->id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            //移动端权限
            if (isset($data['mobile_permission_ids'])) {
                $roleMobilePermission = new RoleMobilePermissionService();
                $roleMobilePermission->fieldDelete('role_id', $role->id);
                foreach ($data['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermission->add([
                        'role_id' => $role->id,
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
     */
    public function delete($id)
    {
        $role = RoleModel::find($id);
        if (empty($role)) {
            throw new Exception('没有找到记录');
        }

        Db::startTrans();
        try {
            $roleDesktopPermission = new RoleDesktopPermissionService();
            $roleDesktopPermission->fieldDelete('role_id', $role->id);

            $roleDesktopMenu = new RoleDesktopMenuService();
            $roleDesktopMenu->fieldDelete('role_id', $role->id);

            $roleDesktopRoute = new RoleDesktopRouteService();
            $roleDesktopRoute->fieldDelete('role_id', $role->id);

            $roleMobilePermission = new RoleMobilePermissionService();
            $roleMobilePermission->fieldDelete('role_id', $role->id);

            $role->delete();
            Db::commit();
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
            Db::rollback();
        }
    }
}