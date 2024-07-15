<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;
use app\service\desktop\Menu as DesktopMenuService;
use app\service\desktop\Permission as DesktopPermissionService;
use app\service\desktop\Route as DesktopRouteService;
use app\service\mobile\Permission as MobilePermissionService;
use app\service\Role as RoleService;
use app\validate\Role as RoleValidate;
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
        $roleModel = RoleModel::with(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions'])
            ->field('id,name')
            ->append(['desktop_permission_ids', 'desktop_menu_ids', 'desktop_route_ids', 'mobile_permission_ids'])
            ->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->hidden(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions']);
        $role = $roleModel->toArray();

        $desktopPermissionService = new DesktopPermissionService();
        $desktopPermissions = $desktopPermissionService->getTreePermissionsWithNameKey();

        $desktopMenuService = new DesktopMenuService();
        $desktopMenus = $desktopMenuService->getTreeMenusWithNameUrl();

        $desktopRouteService = new DesktopRouteService();
        $desktopRoutes = $desktopRouteService->getRoutesWithNamePath();

        $mobilePermissionService = new MobilePermissionService();
        $mobilePermissions = $mobilePermissionService->getTreePermissionsWithNameKey();

        $data = [
            'role' => $role,
            'desktop_permissions' => $desktopPermissions,
            'desktop_menus'=>$desktopMenus,
            'desktop_routes'=>$desktopRoutes,
            'mobile_permissions'=>$mobilePermissions
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
            validate(RoleValidate::class)->scene('desktop_edit')->check($post);
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