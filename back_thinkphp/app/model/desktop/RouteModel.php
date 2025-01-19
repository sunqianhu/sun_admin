<?php

namespace app\model\desktop;

use app\model\BaseModel;
use app\service\desktop\RouteService;
use app\service\DictionaryService;
use app\service\SingletonFactoryService;

class RouteModel extends BaseModel
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
        $route = SingletonFactoryService::getInstance(RouteService::class);
        return $route->getLayoutName($data['layout']);
    }

    /**
     * 得到保活名称
     * @param $value
     * @param $data
     * @return null
     */
    public function getKeepAliveNameAttr($value, $data)
    {
        $route = SingletonFactoryService::getInstance(RouteService::class);
        return $route->getKeepAliveName($data['keep_alive']);
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
