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

class Edit extends Base
{
    /**
     * 初始化修改
     *
     * @return void
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //角色
        $roleModel = RoleModel::with(['desktopPermissions', 'mobilePermissions'])
            ->field('id,name')
            ->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $role = $roleModel->toArray();

        $role['desktop_permission_ids'] = [];
        if (!empty($role['desktopPermissions'])) {
            $role['desktop_permission_ids'] = array_column($role['desktopPermissions'], 'id');
        }
        $role['mobile_permission_ids'] = [];
        if (!empty($role['mobilePermissions'])) {
            $role['mobile_permission_ids'] = array_column($role['mobilePermissions'], 'id');
        }

        //桌面端权限
        $desktopPermissionModels = DesktopPermissionModel::field('id, id, permission_id, name, remark')
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
            'role' => $role,
            'desktop_permissions' => $treeDesktopPermissions,
            'mobile_permissions'=>$treeMobilePermissions
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name', 'desktop_permission_ids' => [], 'mobile_permission_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = RoleModel::find($post['id']);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->save($post);

        //桌面端权限
        $oldDesktopPermissionIds = array_column($roleModel->desktopPermissions->toArray(), 'id');
        $deleteDesktopPermissionIds = array_unique(array_values(array_diff($oldDesktopPermissionIds, $post['desktop_permission_ids'])));
        $addDesktopPermissionIds = array_unique(array_values(array_diff($post['desktop_permission_ids'], $oldDesktopPermissionIds)));
        if(!empty($deleteDesktopPermissionIds)){
            foreach($deleteDesktopPermissionIds as $deleteDesktopPermissionId){
                RoleDesktopPermissionModel::where('role_id', $roleModel->id)
                    ->where('permission_id', $deleteDesktopPermissionId)
                    ->delete();
            }
        }
        if(!empty($addDesktopPermissionIds)) {
            foreach($addDesktopPermissionIds as $addDesktopPermissionId){
                $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                $roleDesktopPermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'permission_id'=>$addDesktopPermissionId
                ]);
            }
        }

        //移动端权限
        $oldMobilePermissionIds = array_column($roleModel->mobilePermissions->toArray(), 'id');
        $deleteMobilePermissionIds = array_unique(array_values(array_diff($oldMobilePermissionIds, $post['mobile_permission_ids'])));
        $addMobilePermissionIds = array_unique(array_values(array_diff($post['mobile_permission_ids'], $oldMobilePermissionIds)));
        if(!empty($deleteMobilePermissionIds)){
            foreach($deleteMobilePermissionIds as $deleteMobilePermissionId){
                RoleMobilePermissionModel::where('role_id', $roleModel->id)
                    ->where('permission_id', $deleteMobilePermissionId)
                    ->delete();
            }
        }
        if(!empty($addMobilePermissionIds)) {
            foreach($addMobilePermissionIds as $addMobilePermissionId){
                $roleMobilePermissionModel = new RoleMobilePermissionModel();
                $roleMobilePermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'permission_id'=>$addMobilePermissionId
                ]);
            }
        }

        return $this->success('修改成功');
    }
}