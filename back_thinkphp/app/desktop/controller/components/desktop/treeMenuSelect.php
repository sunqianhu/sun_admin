<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\service\desktop\Menu;

class treeMenuSelect extends Base
{
    public $noApiAuthActions = [
        'getTreeMenu'
    ];

    /**
     * 得到树权限
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $menu = new Menu();
        $treeMenu = $menu->getTreeMenu();
        return $this->success('获取成功', $treeMenu);
    }
}