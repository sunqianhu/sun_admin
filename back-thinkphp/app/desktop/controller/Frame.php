<?php

namespace app\desktop\controller;

use app\helper\desktop\Module as ModuleHelper;
use app\helper\User as Userhelper;
use app\model\desktop\Module as ModuleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use Sunqianhu\Helper\ArrayHandler;

/**
 * 框架
 */
class Frame extends Base
{
    /**
     * 获取路由
     * @return void
     */
    public function getRoutes()
    {
        $userHelper = new Userhelper();
        $roleIds = $userHelper->getRoleIds($this->user->id);
        if (empty($roleIds)) {
            return $this->success('获取成功', []);
        }

        //页面
        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.id,m.module_id,m.type_id,m.name,m.path,m.key,m.component,m.keep_alive,m.layout')
            ->where('m.type_id', 'in', '1,2')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->group('m.id')
            ->select();
        if ($moduleModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $modules = $moduleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');
        $moduleHelper = new ModuleHelper();
        $mainFirstPageId = $moduleHelper->getMainFirstPageId($treeModules);
        $blankFirstPageId = $moduleHelper->getBlankFirstPageId($treeModules);

        $routes = [];
        foreach ($moduleModels as $moduleModel) {
            if (
                $moduleModel->type_id != 2 ||
                $moduleModel->path === '' ||
                $moduleModel->name === '' ||
                $moduleModel->component === ''
            ) {
                continue;
            }

            //父页面跳转
            $parentRedirect = '';
            if ($moduleModel->id == $mainFirstPageId) {
                $parentRedirect = 'main';
            }
            if ($moduleModel->id == $blankFirstPageId) {
                $parentRedirect = 'blank';
            }

            $route = [];
            $route['path'] = $moduleModel->path;
            $route['name'] = $moduleModel->key;
            $route['component'] = $moduleModel->component;
            $route['layout'] = $moduleModel->layout;
            $route['parent_redirect'] = $parentRedirect;
            $route['meta']['name'] = $moduleModel->name;
            $route['meta']['keep_alive'] = $moduleModel->keep_alive == 1;
            $routes[] = $route;
        }

        return $this->success('获取成功', $routes);
    }

    /**
     * 获取权限
     * @return void
     */
    public function getPermissions()
    {
        $userHelper = new Userhelper();
        $roleIds = $userHelper->getRoleIds($this->user->id);
        if (empty($roleIds)) {
            return $this->success('获取成功', []);
        }

        //模块
        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.key')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->group('m.id')
            ->select();
        if ($moduleModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $permissions = [];
        foreach ($moduleModels as $moduleModel) {
            $permissions[] = $moduleModel->key;
        }
        if(!empty($permissions)){
            $permissions = array_unique($permissions);
        }

        return $this->success('获取成功', $permissions);
    }

    /**
     * 获取水印
     * @return void
     */
    public function getWatermark()
    {
        $userModel = UserModel::field('id,name')->find($this->user->id);
        if (empty($userModel)) {
            return $this->error('没有找到用户记录');
        }
        $data = [
            'id' => $userModel->id,
            'name' => $userModel->name,
            'time' => date('Y-m-d H:i:s')
        ];
        return $this->success('获取成功', $data);
    }
}