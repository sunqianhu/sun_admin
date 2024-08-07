<?php

namespace app\model\desktop;

use app\model\Base;
use app\service\Dictionary as DictionaryService;

class Route extends Base
{
    protected $name = 'desktop_route';

    /**
     * 得到布局容器名称
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

    /**
     * 名称和路径
     * @param $value
     * @param $data
     * @return string
     */
    public function getNamePathAttr($value, $data)
    {
        $namePath = $data['name'];
        if(isset($data['path']) && $data['path'] !== ''){
            $namePath = $data['name'].'（'.$data['path'].'）';
        }
        return $namePath;
    }
}
