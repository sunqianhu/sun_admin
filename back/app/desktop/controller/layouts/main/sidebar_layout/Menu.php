<?php

namespace app\desktop\controller\layouts\main\sidebar_layout;

use app\desktop\controller\Base;
use app\service\user\UserDesktopMenuService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Menu extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树形菜单
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $userDesktopMenuService = new UserDesktopMenuService();
        $treeMenu = $userDesktopMenuService->getTreeMenu($this->userId);

        return $this->getSuccessResonse('获取成功', $treeMenu);
    }
}