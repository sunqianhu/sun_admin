<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\helper\desktop\MenuHelper as DesktopMenuHelper;
use app\helper\PermissionHelper;
use app\helper\desktop\RouteHelper as DesktopRouteHelper;
use app\helper\role\RoleDesktopMenuHelper;
use app\helper\role\RolePermissionHelper;
use app\helper\role\RoleDesktopRouteHelper;
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
        $permissionHelper = new PermissionHelper();
        $treePermission = $permissionHelper->getTreePermission(0);

        $desktopMenuHelper = new DesktopMenuHelper();
        $desktopTreeMenu = $desktopMenuHelper->getTreeMenu(0);

        $desktopRouteHelper = new DesktopRouteHelper();
        $desktopRoutes = $desktopRouteHelper->getRoutes();

        $data = [
            'tree_permission' => $treePermission,
            'desktop_tree_menu' => $desktopTreeMenu,
            'desktop_routes' => $desktopRoutes
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name', 'permission_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => []]);

        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            $idsValidator = new IdsValidator();
            $idsValidator->check('权限', $post['permission_ids']);
            $idsValidator->check('桌面端菜单', $post['desktop_menu_ids']);
            $idsValidator->check('桌面端路由', $post['desktop_route_ids']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try {
            $roleModel = new RoleModel();
            $roleModel->save(['name' => $post['name']]);
            $id = $roleModel->id;

            $rolePermissionHelper = new RolePermissionHelper();
            $rolePermissionHelper->setRelation($id, $post['permission_ids']);

            $roleDesktopMenuHelper = new RoleDesktopMenuHelper();
            $roleDesktopMenuHelper->setRelation($id, $post['desktop_menu_ids']);

            $roleDesktopRouteHelper = new RoleDesktopRouteHelper();
            $roleDesktopRouteHelper->setRelation($id, $post['desktop_route_ids']);

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
