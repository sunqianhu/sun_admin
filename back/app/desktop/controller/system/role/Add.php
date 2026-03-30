<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\helper\desktop\MenuHelper as DesktopMenuHelper;
use app\helper\desktop\PermissionHelper as DesktopPermissionHelper;
use app\helper\desktop\RouteHelper as DesktopRouteHelper;
use app\helper\mobile\PermissionHelper as MobilePermissionHelper;
use app\helper\role\RoleDesktopMenuHelper;
use app\helper\role\RoleDesktopPermissionHelper;
use app\helper\role\RoleDesktopRouteHelper;
use app\helper\role\RoleMobilePermissionHelper;
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
        $desktopPermissionHelper = new DesktopPermissionHelper();
        $desktopTreePermission = $desktopPermissionHelper->getTreePermission(0);

        $desktopMenuHelper = new DesktopMenuHelper();
        $desktopTreeMenu = $desktopMenuHelper->getTreeMenu(0);

        $desktopRouteHelper = new DesktopRouteHelper();
        $desktopRoutes = $desktopRouteHelper->getRoutes();

        $mobilePermissionHelper = new MobilePermissionHelper();
        $mobileTreePermission = $mobilePermissionHelper->getTreePermission(0);

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
            $idsValidator = new IdsValidator();
            $idsValidator->check('桌面端权限', $post['desktop_permission_ids']);
            $idsValidator->check('桌面端菜单', $post['desktop_menu_ids']);
            $idsValidator->check('桌面端路由', $post['desktop_route_ids']);
            $idsValidator->check('移动端权限', $post['mobile_permission_ids']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $roleModel = new RoleModel();
            $roleModel->save($post);
            $id = $roleModel->id;

            $roleDesktopPermissionHelper = new RoleDesktopPermissionHelper();
            $roleDesktopPermissionHelper->setRelation($id, $post['desktop_permission_ids']);

            $roleDesktopMenuHelper = new RoleDesktopMenuHelper();
            $roleDesktopMenuHelper->setRelation($id, $post['desktop_menu_ids']);

            $roleDesktopRouteHelper = new RoleDesktopRouteHelper();
            $roleDesktopRouteHelper->setRelation($id, $post['desktop_route_ids']);

            $roleMobilePermissionHelper = new RoleMobilePermissionHelper();
            $roleMobilePermissionHelper->setRelation($id, $post['mobile_permission_ids']);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}