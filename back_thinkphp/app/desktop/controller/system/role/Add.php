<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\service\desktop\MenuService as DesktopMenu;
use app\service\desktop\PermissionService as DesktopPermission;
use app\service\desktop\RouteService as DesktopRoute;
use app\service\mobile\PermissionService as MobilePermission;
use app\service\RoleService;
use app\validate\RoleValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $desktopPermission = new DesktopPermission();
        $desktopTreePermission = $desktopPermission->getNameKeyTreePermission();

        $desktopMenu = new DesktopMenu();
        $desktopTreeMenu = $desktopMenu->getNameUrlTreeMenu();

        $desktopRoute = new DesktopRoute();
        $desktopRoutes = $desktopRoute->getNamePathRoutes();

        $mobilePermission = new MobilePermission();
        $mobileTreePermission = $mobilePermission->getNameKeyTreePermission();

        $data = [
            'desktop_tree_permission' => $desktopTreePermission,
            'desktop_tree_menu'=>$desktopTreeMenu,
            'desktop_routes'=>$desktopRoutes,
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
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $role = new RoleService();
        try{
            $role->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}