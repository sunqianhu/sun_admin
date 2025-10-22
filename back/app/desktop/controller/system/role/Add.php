<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\desktop\MenuService as DesktopMenuService;
use app\service\desktop\PermissionService as DesktopPermissionService;
use app\service\desktop\RouteService as DesktopRouteService;
use app\service\mobile\PermissionService as MobilePermissionService;
use app\service\role\RoleDesktopMenuService;
use app\service\role\RoleDesktopPermissionService;
use app\service\role\RoleDesktopRouteService;
use app\service\role\RoleMobilePermissionService;
use app\validate\RoleValidate;
use Exception;
use Sunqianhu\Helper\IdsValidator;
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
        return $this->getSuccessResponse('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name', 'desktop_permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => [], 'mobile_permission_ids' => []]);

        try{
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            IdsValidator::check('桌面端权限', $post['desktop_permission_ids']);
            IdsValidator::check('桌面端菜单', $post['desktop_menu_ids']);
            IdsValidator::check('桌面端路由', $post['desktop_route_ids']);
            IdsValidator::check('移动端权限', $post['mobile_permission_ids']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $roleModel = new RoleModel();
            $roleModel->save($post);
            $id = $roleModel->id;

            $RoleDesktopPermissionService = new RoleDesktopPermissionService();
            $RoleDesktopPermissionService->setRelation($id, $post['desktop_permission_ids']);

            $roleDesktopMenuService = new RoleDesktopMenuService();
            $roleDesktopMenuService->setRelation($id, $post['desktop_menu_ids']);

            $roleDesktopRouteService = new RoleDesktopRouteService();
            $roleDesktopRouteService->setRelation($id, $post['desktop_route_ids']);

            $roleMobilePermissionService = new RoleMobilePermissionService();
            $roleMobilePermissionService->setRelation($id, $post['mobile_permission_ids']);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}