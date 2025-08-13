<?php

namespace app\desktop\controller\components\desktop\route;

use app\desktop\controller\Base;
use app\service\DictionaryService;
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
        $dictionaryService = new DictionaryService();
        $layouts = $dictionaryService->getList('desktop_route_layout');

        return $this->getSuccessResonse('获取成功', $layouts);
    }
}