<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\service\desktop\Menu as  DesktopMenuService;
use app\service\desktop\Permission as DesktopPermissionService;
use app\service\desktop\Route as DesktopRouteService;
use app\service\mobile\Permission as MobilePermissionService;
use app\service\Role as  RoleService;
use app\validate\Role as RoleValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $desktopPermissionService = new DesktopPermissionService();
        $desktopPermissions = $desktopPermissionService->getTreePermissionsWithNameKey();

        $desktopMenuService = new DesktopMenuService();
        $desktopMenus = $desktopMenuService->getTreeMenusWithNameUrl();

        $desktopRouteService = new DesktopRouteService();
        $desktopRoutes = $desktopRouteService->getRoutesWithNamePath();

        $mobilePermissionService = new MobilePermissionService();
        $mobilePermissions = $mobilePermissionService->getTreePermissionsWithNameKey();

        $data = [
            'desktop_permissions'=>$desktopPermissions,
            'desktop_menus'=>$desktopMenus,
            'desktop_routes'=>$desktopRoutes,
            'mobile_permissions'=>$mobilePermissions,
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
            validate(RoleValidate::class)->scene('desktop_add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleService = new RoleService();
        try{
            $roleService->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}