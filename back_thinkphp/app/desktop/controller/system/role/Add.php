<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;
use app\model\RoleModel;
use app\service\CrudService;
use app\service\desktop\MenuService as DesktopMenuService;
use app\service\desktop\PermissionService as DesktopPermissionService;
use app\service\desktop\RouteService as DesktopRouteService;
use app\service\mobile\PermissionService as MobilePermissionService;
use app\validate\IdArrayValidate;
use app\validate\RoleValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Db;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $desktopPermissionService = new DesktopPermissionService();
        $desktopTreePermission = $desktopPermissionService->getNameKeyTreePermission();

        $desktopMenuService = new DesktopMenuService();
        $desktopTreeMenu = $desktopMenuService->getNameUrlTreeMenu();

        $desktopRouteService = new DesktopRouteService();
        $desktopRouteServices = $desktopRouteService->getNamePathRoutes();

        $mobilePermissionService = new MobilePermissionService();
        $mobileTreePermission = $mobilePermissionService->getNameKeyTreePermission();

        $data = [
            'desktop_tree_permission' => $desktopTreePermission,
            'desktop_tree_menu'=>$desktopTreeMenu,
            'desktop_routes'=>$desktopRouteServices,
            'mobile_tree_permission'=>$mobileTreePermission
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name', 'desktop_permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => [], 'mobile_permission_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
            IdArrayValidate::check($post['desktop_permission_ids'], '桌面端权限');
            IdArrayValidate::check($post['desktop_menu_ids'], '桌面端菜单');
            IdArrayValidate::check($post['desktop_route_ids'], '桌面端路由');
            IdArrayValidate::check($post['mobile_permission_ids'], '移动端权限');
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        Db::startTrans();
        try{
            $roleCrudService = new CrudService(RoleModel::class);
            $id = $roleCrudService->add($post);

            //桌面端权限
            if (!empty($post['desktop_permission_ids'])) {
                $roleDesktopPermissionCrudService = new CrudService(RoleDesktopPermissionModel::class);
                foreach ($post['desktop_permission_ids'] as $desktopPermissionId) {
                    $roleDesktopPermissionCrudService->add([
                        'role_id' => $id,
                        'permission_id' => $desktopPermissionId
                    ]);
                }
            }

            //桌面端菜单
            if (!empty($post['desktop_menu_ids'])) {
                $roleDesktopMenuCrudService = new CrudService(RoleDesktopMenuModel::class);
                foreach ($post['desktop_menu_ids'] as $desktopMenuId) {
                    $roleDesktopMenuCrudService->add([
                        'role_id' => $id,
                        'menu_id' => $desktopMenuId
                    ]);
                }
            }

            //桌面端路由
            if (!empty($post['desktop_route_ids'])) {
                $roleDesktopRouteCrudService = new CrudService(RoleDesktopRouteModel::class);
                foreach ($post['desktop_route_ids'] as $desktopRouteId) {
                    $roleDesktopRouteCrudService->add([
                        'role_id' => $id,
                        'route_id' => $desktopRouteId
                    ]);
                }
            }

            //移动端权限
            if (!empty($post['mobile_permission_ids'])) {
                $roleMobilePermissionCrudService = new CrudService(RoleMobilePermissionModel::class);
                foreach ($post['mobile_permission_ids'] as $mobilePermissionId) {
                    $roleMobilePermissionCrudService->add([
                        'role_id' => $id,
                        'permission_id' => $mobilePermissionId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}