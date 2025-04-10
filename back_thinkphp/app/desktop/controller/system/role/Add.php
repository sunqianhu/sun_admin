<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\CrudService;
use app\service\desktop\MenuService as DesktopMenuService;
use app\service\desktop\PermissionService as DesktopPermissionService;
use app\service\desktop\RouteService as DesktopRouteService;
use app\service\mobile\PermissionService as MobilePermissionService;
use app\service\RoleService;
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

            $roleService = new RoleService();
            $roleService->updateDesktopPermissionRelation($id, $post['desktop_permission_ids']);
            $roleService->updateDesktopMenuRelation($id, $post['desktop_menu_ids']);
            $roleService->updateDesktopRouteRelation($id, $post['desktop_route_ids']);
            $roleService->updateMobilePermissionRelation($id, $post['mobile_permission_ids']);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}