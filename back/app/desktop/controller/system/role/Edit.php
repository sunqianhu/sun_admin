<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\helper\DataScopeHelper;
use app\helper\RoleHelper;
use app\model\RoleModel;
use app\helper\desktop\MenuHelper as DesktopMenuHelper;
use app\helper\PermissionHelper;
use app\helper\desktop\RouteHelper as DesktopRouteHelper;
use app\helper\role\RoleDesktopMenuHelper;
use app\helper\role\RolePermissionHelper;
use app\helper\role\RoleDesktopRouteHelper;
use app\helper\role\RolePolicyHelper;
use app\helper\user\UserDataScopeHelper;
use app\validate\IdValidate;
use app\validate\RoleValidate;
use Exception;
use Sunqianhu\Helper\IdsValidator;
use think\exception\ValidateException;
use think\facade\Db;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id' => 0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $roleModel = RoleModel::with(['permissions' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'policies' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'desktop_routes' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }, 'desktop_menus' => function ($query) {
            $query->field('id,name')->hidden(['pivot']);
        }])
            ->field('id,name')
            ->append(['permission_ids', 'policy_ids', 'desktop_menu_ids', 'desktop_route_ids'])
            ->find($get['id']);
        if (empty($roleModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $roleModel->hidden(['permissions', 'policies', 'desktop_routes', 'desktop_menus']);
        $role = $roleModel->toArray();

        $dataScopeHelper = new DataScopeHelper();
        $dataScopes = $dataScopeHelper->getDataScopes();

        $permissionHelper = new PermissionHelper();
        $treePermission = $permissionHelper->getTreePermission(0);

        $desktopMenuHelper = new DesktopMenuHelper();
        $desktopTreeMenu = $desktopMenuHelper->getTreeMenu(0);

        $desktopRouteHelper = new DesktopRouteHelper();
        $desktopRoutes = $desktopRouteHelper->getRoutes();

        $data = [
            'role' => $role,
            'tree_permission' => $treePermission,
            'data_scopes' => $dataScopes,
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
        $post = $this->request->post(['id', 'name', 'permission_ids' => [], 'policy_ids' => [], 'desktop_menu_ids' => [], 'desktop_route_ids' => []]);

        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
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
            $id = $post['id'];
            $roleHelper = new RoleHelper();
            $roleHelper->edit($id, ['name' => $post['name']]);

            $rolePermissionHelper = new RolePermissionHelper();
            $rolePermissionHelper->updateRelateByPermissionIds($id, $post['permission_ids']);

            $roleDesktopMenuHelper = new RoleDesktopMenuHelper();
            $roleDesktopMenuHelper->updateRelateByMenuIds($id, $post['desktop_menu_ids']);

            $roleDesktopRouteHelper = new RoleDesktopRouteHelper();
            $roleDesktopRouteHelper->updateRelateByRouteIds($id, $post['desktop_route_ids']);

            $rolePolicyHelper = new RolePolicyHelper();
            $rolePolicyHelper->updateRelateByPolicyIds($id, $post['policy_ids']);

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        $userDataScopeHelper = new UserDataScopeHelper();
        $userDataScopeHelper->clearCache();

        return $this->getSuccessResponse('修改成功');
    }
}
