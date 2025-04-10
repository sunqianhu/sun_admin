<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\service\desktop\MenuService;

class treeMenuSelect extends Base
{
    public $isApiAuth = false;

    /**
     * 得到树权限
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $menuService = new MenuService();
        $treeMenu = $menuService->getTreeMenu();
        return $this->success('获取成功', $treeMenu);
    }
}