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
        $desktopPermissionModels = DesktopPermissionModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $desktopModules = $desktopPermissionModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDesktopModules = $arrayHandler->convertTree($desktopModules, 'id', 'module_id', 'children');

        //移动端权限
        $mobilePermissionModels = MobilePermissionModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $mobileModules = $mobilePermissionModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMobileModules = $arrayHandler->convertTree($mobileModules, 'id', 'module_id', 'children');

        $data = [
            'desktop_modules'=>$treeDesktopModules,
            'mobile_modules'=>$treeMobileModules,
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name', 'desktop_module_ids' => [], 'mobile_module_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = new RoleModel();
        $roleModel->save($post);

        if (!empty($post['desktop_module_ids'])) {
            foreach($post['desktop_module_ids'] as $desktopModuleId){
                $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                $roleDesktopPermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$desktopModuleId
                ]);
            }
        }

        if (!empty($post['mobile_module_ids'])) {
            foreach($post['mobile_module_ids'] as $mobileModuleId){
                $roleMobilePermissionModel = new RoleMobilePermissionModel();
                $roleMobilePermissionModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$mobileModuleId
                ]);
            }
        }

        return $this->success('添加成功');
    }
}