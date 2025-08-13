<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\desktop\MenuService as DesktopMenuService;
use app\service\desktop\PermissionService as DesktopPermissionService;
use app\service\desktop\RouteService as DesktopRouteService;
use app\service\mobile\PermissionService as MobilePermissionService;
use app\service\RoleDesktopMenuService;
use app\service\RoleDesktopPermissionService;
use app\service\RoleDesktopRouteService;
use app\service\RoleMobilePermissionService;
use Sunqianhu\Helper\IdsValidate;
use app\validate\IdValidate;
use app\validate\RoleValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\facade\Db;
use think\Response;

class Edit extends Base
{
    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $get = $this->request->get(['id' => 0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        //角色
        $roleModel = RoleModel::with(['desktop_permissions' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'desktop_routes' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'desktop_menus' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'mobile_permissions' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }])
            ->field('id,name')
            ->append(['desktop_permission_ids', 'desktop_menu_ids', 'desktop_route_ids', 'mobile_permission_ids'])
            ->find($id);
        if (empty($roleModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $roleModel->hidden(['desktop_permissions', 'desktop_routes', 'desktop_menus', 'mobile_permissions']);
        $role = $roleModel->toArray();

        $desktopPermissionService = new DesktopPermissionService();
        $desktopTreePermission = $desktopPermissionService->getTreePermission(0);

        $desktopMenuService = new DesktopMenuService();
        $desktopTreeMenu = $desktopMenuService->getTreeMenu(0);

        $desktopRouteService = new DesktopRouteService();
        $desktopRoutes = $desktopRouteService->getRoutes();

        $mobilePermissionService = new MobilePermissionService();
        $mobileTreePermission = $mobilePermissionService->getTreePermission(0);

        $data = [
            'role' => $role,
            'desktop_tree_permission' => $desktopTreePermission,
            'desktop_tree_menu' => $desktopTreeMenu,
            'desktop_routes' => $desktopRoutes,
            'mobile_tree_permission' => $mobileTreePermission
        ];
        return $this->getSuccessResonse('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name', 'desktop_permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => [], 'mobile_permission_ids' => []]);

        try{
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            IdsValidate::check($post['desktop_permission_ids'], '桌面端权限');
            IdsValidate::check($post['desktop_menu_ids'], '桌面端菜单');
            IdsValidate::check($post['desktop_route_ids'], '桌面端路由');
            IdsValidate::check($post['mobile_permission_ids'], '移动端权限');
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try {
            $roleModel = RoleModel::findOrEmpty($post['id']);
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
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('修改成功');
    }
}