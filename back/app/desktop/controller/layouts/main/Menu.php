<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\service\desktop\DesktopUserService;
use think\Response;

class Menu extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树形菜单
     * @return Response
     */
    public function getTreeMenu()
    {
        $desktopUserService = new DesktopUserService();
        $treeMenu = $desktopUserService->getTreeMenu($this->userId);

        return $this->getSuccessResonse('获取成功', $treeMenu);
    }
}