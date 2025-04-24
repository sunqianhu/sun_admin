<?php

namespace app\desktop\controller\components\desktop\route;

use app\desktop\controller\Base;
use app\service\DictionaryService;
use think\Response;

class LayoutSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到路由
     * @return Response
     */
    public function getLayouts()
    {
        $dictionaryService = new DictionaryService();
        $layouts = $dictionaryService->getList('desktop_route_layout');

        return $this->success('获取成功', $layouts);
    }
}