<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\helper\DataScopeHelper;
use app\helper\RoleHelper;
use app\helper\desktop\MenuHelper;
use app\helper\PermissionHelper;
use app\helper\desktop\RouteHelper;
use app\helper\role\DesktopMenuHelper;
use app\helper\role\PermissionHelper as RolePermissionHelper;
use app\helper\role\DesktopRouteHelper;
use app\helper\role\RolePolicyHelper;
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

        $menuHelper = new MenuHelper();
        $desktopTreeMenu = $menuHelper->getTreeMenu(0);

        $routeHelper = new RouteHelper();
        $desktopRoutes = $routeHelper->getRoutes();

        $dataScopeHelper = new DataScopeHelper();
        $dataScopes = $dataScopeHelper->getDataScopes();

        $data = [
            'tree_permission' => $treePermission,
            'desktop_tree_menu' => $desktopTreeMenu,
            'desktop_routes' => $desktopRoutes,
            'data_scopes' => $dataScopes
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name', 'permission_ids' => [], 'policy_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => []]);

        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            $idsValidator = new IdsValidator();
            $idsValidator->check('功能权限', $post['permission_ids']);
            $idsValidator->check('数据权限', $post['policy_ids']);
            $idsValidator->check('桌面端菜单', $post['desktop_menu_ids']);
            $idsValidator->check('桌面端路由', $post['desktop_route_ids']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try {
            $roleHelper = new RoleHelper();
            $id = $roleHelper->add(['name' => $post['name']]);

            $rolePermissionHelper = new RolePermissionHelper();
            $rolePermissionHelper->updateRelateByPermissionIds($id, $post['permission_ids']);

            $desktopMenuHelper = new DesktopMenuHelper();
            $desktopMenuHelper->updateRelateByMenuIds($id, $post['desktop_menu_ids']);

            $desktopRouteHelper = new DesktopRouteHelper();
            $desktopRouteHelper->updateRelateByRouteIds($id, $post['desktop_route_ids']);

            $rolePolicyHelper = new RolePolicyHelper();
            $rolePolicyHelper->updateRelateByPolicyIds($id, $post['policy_ids']);

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
