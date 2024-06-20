<?php

namespace app\desktop\controller\frame;

use app\desktop\controller\Base;
use app\model\desktop\Module as ModuleModel;
use app\model\User as UserModel;
use app\service\Config as ConfigHelper;
use app\service\User as UserService;
use Sunqianhu\Helper\ArrayHandler;

/**
 * 主页
 */
class Main extends Base
{
    /**
     * 初始化
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $configHelper = new ConfigHelper();
        $config = [
            'version' => $configHelper->getValue('version')
        ];

        $data = [
            'config' => $config
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
    {
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($this->user->id);
        if (empty($roleIds)) {
            return $this->success('获取成功', []);
        }

        //模块
        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.*')
            ->where('m.type_id', 'in', '1,2,4')
            ->where('rdm.role_id', 'in', $roleIds)
            ->where('show', 1)
            ->order('m.sort', 'asc')
            ->group('m.id')
            ->select();
        if ($moduleModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $menus = [];
        foreach ($moduleModels as $moduleModel) {
            $menu = [];
            $menu['id'] = $moduleModel->id;
            $menu['menu_id'] = $moduleModel->module_id;
            $menu['type_id'] = $moduleModel->type_id;
            $menu['name'] = $moduleModel->name;
            $menu['path'] = $moduleModel->path;
            $menu['url'] = $moduleModel->url;
            $menu['icon'] = $moduleModel->icon;
            $menus[] = $menu;
        }
        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 得到头像
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getAvatar()
    {
        $userModel = UserModel::field('avatar')->find($this->user->id);
        $avatar = $userModel->avatar_url;
        return $this->success('获取成功', $avatar);
    }
}