<?php

namespace app\model\desktop;

use app\model\Base;
use app\service\Dictionary as DictionaryService;

class Route extends Base
{
    protected $name = 'desktop_route';

    /**
     * 得到布局名称
     * @param $value
     * @param $data
     * @return null
     */
    public function getLayoutNameAttr($value, $data)
    {
        $dictionaryService = new DictionaryService();
        return $dictionaryService->getValue('desktop_route_layout', $data['layout']);
    }

    /**
     * 得到保活名称
     * @param $value
     * @param $data
     * @return null
     */
    public function getKeepAliveNameAttr($value, $data)
    {
        $dictionaryService = new DictionaryService();
        return $dictionaryService->getValue('desktop_route_keep_alive', $data['keep_alive']);
    }

}
