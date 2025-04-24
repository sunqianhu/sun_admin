<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\service\desktop\MenuService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class treeMenuSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树权限
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $menuService = new MenuService();
        $treeMenu = $menuService->getTreeMenu();
        return $this->success('获取成功', $treeMenu);
    }
}