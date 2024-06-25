<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\desktop\Permission as DesktopPermissionModel;
use app\model\mobile\Permission as MobilePermissionModel;
use app\model\Role as RoleModel;
use app\model\RoleDesktopPermission as RoleDesktopPermissionModel;
use app\model\RoleMobilePermission as RoleMobilePermissionModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        //桌面端权限
        $desktopPermissionModels = DesktopPermissionModel::field('id, permission_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $desktopPermissions = $desktopPermissionModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDesktopPermissions = $arrayHandler->convertTree($desktopPermissions, 'id', 'permission_id', 'children');

        //移动端权限
        $mobilePermissionModels = MobilePermissionModel::field('id, permission_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $mobilePermissions = $mobilePermissionModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMobilePermissions = $arrayHandler->convertTree($mobilePermissions, 'id', 'permission_id', 'children');

        $data = [
            'desktop_permissions'=>$treeDesktopPermissions,
            'mobile_permissions'=>$treeMobilePermissions,
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name', 'desktop_permission_ids' => [], 'mobile_permission_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = new RoleModel();
        $roleModel->save($post);

        if (!empty($post['desktop_permission_ids'])) {
            foreach($post['desktop_permission_ids'] as $desktopPermissionId){
                $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                $roleDesktopPermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'permission_id'=>$desktopPermissionId
                ]);
            }
        }

        if (!empty($post['mobile_permission_ids'])) {
            foreach($post['mobile_permission_ids'] as $mobilePermissionId){
                $roleMobilePermissionModel = new RoleMobilePermissionModel();
                $roleMobilePermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'permission_id'=>$mobilePermissionId
                ]);
            }
        }

        return $this->success('添加成功');
    }
}