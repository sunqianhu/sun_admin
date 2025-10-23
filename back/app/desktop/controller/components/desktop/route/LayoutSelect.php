<?php

namespace app\desktop\controller\components\desktop\route;

use app\desktop\controller\Base;
use app\helper\DictionaryHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class LayoutSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到路由
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getLayouts()
    {
        $dictionaryHelper = new DictionaryHelper();
        $layouts = $dictionaryHelper->getList('desktop_route_layout');

        return $this->getSuccessResponse('获取成功', $layouts);
    }
}