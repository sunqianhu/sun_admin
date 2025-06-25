<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use Sunqianhu\Helper\thinkphp\Crud;
use app\service\desktop\MenuService as DesktopMenuService;
use app\service\desktop\PermissionService as DesktopPermissionService;
use app\service\desktop\RouteService as DesktopRouteService;
use app\service\mobile\PermissionService as MobilePermissionService;
use app\service\RoleService;
use Sunqianhu\Helper\IdsValidate;
use app\validate\RoleValidate;
use Exception;
use think\facade\Db;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $desktopPermissionService = new DesktopPermissionService();
        $desktopTreePermission = $desktopPermissionService->getTreePermission(0);

        $desktopMenuService = new DesktopMenuService();
        $desktopTreeMenu = $desktopMenuService->getTreeMenu(0);

        $desktopRouteService = new DesktopRouteService();
        $desktopRoutes = $desktopRouteService->getRoutes();

        $mobilePermissionService = new MobilePermissionService();
        $mobileTreePermission = $mobilePermissionService->getTreePermission(0);

        $data = [
            'desktop_tree_permission' => $desktopTreePermission,
            'desktop_tree_menu'=>$desktopTreeMenu,
            'desktop_routes'=>$desktopRoutes,
            'mobile_tree_permission'=>$mobileTreePermission
        ];
        return $this->getSuccessResonse('获取成功', $data);
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
            IdsValidate::check($post['desktop_permission_ids'], '桌面端权限');
            IdsValidate::check($post['desktop_menu_ids'], '桌面端菜单');
            IdsValidate::check($post['desktop_route_ids'], '桌面端路由');
            IdsValidate::check($post['mobile_permission_ids'], '移动端权限');
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $roleCrud = new Crud(RoleModel::class);
            $id = $roleCrud->insert($post);

            $roleService = new RoleService();
            $roleService->updateDesktopPermissionRelation($id, $post['desktop_permission_ids']);
            $roleService->updateDesktopMenuRelation($id, $post['desktop_menu_ids']);
            $roleService->updateDesktopRouteRelation($id, $post['desktop_route_ids']);
            $roleService->updateMobilePermissionRelation($id, $post['mobile_permission_ids']);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}