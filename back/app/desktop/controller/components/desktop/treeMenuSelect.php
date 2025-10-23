<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\helper\desktop\MenuHelper;
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
        $get = $this->request->get(['menu_id'=>0]);
        if(!is_numeric($get['menu_id'])){
            return $this->getErrorResponse('menu_id参数错误');
        }

        $menuHelper = new MenuHelper();
        $treeMenu = $menuHelper->getTreeMenu($get['menu_id']);
        return $this->getSuccessResponse('获取成功', $treeMenu);
    }
}