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
use app\validate\IdArrayValidate;
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
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        //角色
        $roleModel = RoleModel::with(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions'])
            ->field('id,name')
            ->append(['desktop_permission_ids', 'desktop_menu_ids', 'desktop_route_ids', 'mobile_permission_ids'])
            ->find($id);
        if (empty($roleModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $roleModel->hidden(['desktopPermissions', 'desktopRoutes', 'desktopMenus', 'mobilePermissions']);
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
        $post = $this->request->post(['id', 'name', 'desktop_permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => [], 'mobile_permission_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
            IdArrayValidate::check($post['desktop_permission_ids'], '桌面端权限');
            IdArrayValidate::check($post['desktop_menu_ids'], '桌面端菜单');
            IdArrayValidate::check($post['desktop_route_ids'], '桌面端路由');
            IdArrayValidate::check($post['mobile_permission_ids'], '移动端权限');
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        Db::startTrans();
        try{
            $roleCrud = new Crud(RoleModel::class);
            $roleCrud->update($post['id'], $post);
            $id = $post['id'];

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

        return $this->getSuccessResonse('修改成功');
    }
}