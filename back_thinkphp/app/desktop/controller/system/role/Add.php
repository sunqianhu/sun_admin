<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\desktop\Module as DesktopModuleModel;
use app\model\mobile\Module as MobileModuleModel;
use app\model\Role as RoleModel;
use app\model\RoleDesktopModule as RoleDesktopModuleModel;
use app\model\RoleMobileModule as RoleMobileModuleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        //桌面端模块
        $desktopModuleModels = DesktopModuleModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $desktopModules = $desktopModuleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDesktopModules = $arrayHandler->convertTree($desktopModules, 'id', 'module_id', 'children');

        //移动端模块
        $mobileModuleModels = MobileModuleModel::field('id, module_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $mobileModules = $mobileModuleModels->toArray();
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
                $roleDesktopModuleModel = new RoleDesktopModuleModel();
                $roleDesktopModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$desktopModuleId
                ]);
            }
        }

        if (!empty($post['mobile_module_ids'])) {
            foreach($post['mobile_module_ids'] as $mobileModuleId){
                $roleMobileModuleModel = new RoleMobileModuleModel();
                $roleMobileModuleModel->save([
                    'role_id'=>$roleModel->id,
                    'module_id'=>$mobileModuleId
                ]);
            }
        }

        return $this->success('添加成功');
    }
}