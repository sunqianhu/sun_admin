<?php

namespace app\desktop\controller\components\desktop\route;

use app\desktop\controller\Base;
use app\service\Dictionary;

class LayoutSelect extends Base
{
    public $noApiAuthActions = [
        'getLayouts'
    ];

    /**
     * 得到路由
     * @return \think\Response
     */
    public function getLayouts()
    {
        $dictionary = new Dictionary();
        $layouts = $dictionary->getList('desktop_route_layout');

        return $this->success('获取成功', $layouts);
    }
}