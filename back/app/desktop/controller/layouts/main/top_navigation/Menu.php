<?php

namespace app\desktop\controller\layouts\main\top_navigation;

use app\desktop\controller\Base;
use app\helper\user\DesktopMenuHelper;
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
        $desktopMenuHelper = new DesktopMenuHelper();
        $treeMenu = $desktopMenuHelper->getTreeMenu($this->request->userId);

        return $this->getSuccessResponse('获取成功', $treeMenu);
    }
}