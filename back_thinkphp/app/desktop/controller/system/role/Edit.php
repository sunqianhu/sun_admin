<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\desktop\MenuService as DesktopMenu;
use app\service\desktop\PermissionService as DesktopPermission;
use app\service\desktop\RouteService as DesktopRoute;
use app\service\mobile\PermissionService as MobilePermission;
use app\service\RoleService;
use app\validate\RoleValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     *
     * @return void
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //角色
        $role = RoleModel::with(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions'])
            ->field('id,name')
            ->append(['desktop_permission_ids', 'desktop_menu_ids', 'desktop_route_ids', 'mobile_permission_ids'])
            ->find($id);
        if (empty($role)) {
            return $this->error('没有找到记录');
        }
        $roleService->hidden(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions']);
        $roleArray = $roleService->toArray();

        $desktopPermission = new DesktopPermission();
        $desktopTreePermission = $desktopPermission->getNameKeyTreePermission();

        $desktopMenu = new DesktopMenu();
        $desktopTreeMenu = $desktopMenu->getNameUrlTreeMenu();

        $desktopRoute = new DesktopRoute();
        $desktopRoutes = $desktopRoute->getNamePathRoutes();

        $mobilePermission = new MobilePermission();
        $mobileTreePermission = $mobilePermission->getNameKeyTreePermission();

        $data = [
            'role' => $roleArray,
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
        $post = $this->request->post(['id', 'name', 'desktop_permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => [], 'mobile_permission_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleService = new RoleService();
        try{
            $roleService->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}