<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\desktop\Menu as DesktopMenu;
use app\service\desktop\Permission as DesktopPermission;
use app\service\desktop\Route as DesktopRoute;
use app\service\mobile\Permission as MobilePermission;
use app\service\Role;
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
        $roleModel = RoleModel::with(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions'])
            ->field('id,name')
            ->append(['desktop_permission_ids', 'desktop_menu_ids', 'desktop_route_ids', 'mobile_permission_ids'])
            ->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->hidden(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions']);
        $role = $roleModel->toArray();

        $desktopPermission = new DesktopPermission();
        $desktopPermissions = $desktopPermission->getNameKeyTreePermission();

        $desktopMenu = new DesktopMenu();
        $desktopMenus = $desktopMenu->getNameUrlTreeMenu();

        $desktopRoute = new DesktopRoute();
        $desktopRoutes = $desktopRoute->getNamePathRoutes();

        $mobilePermission = new MobilePermission();
        $mobilePermissions = $mobilePermission->getNameKeyTreePermission();

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
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $role = new Role();
        try{
            $role->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}