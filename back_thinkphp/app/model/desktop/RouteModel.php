<?php

namespace app\model\desktop;

use app\model\BaseModel;
use app\service\desktop\RouteService;
use Exception;
use Sunqianhu\Helper\SingletonFactory;

class RouteModel extends BaseModel
{
    protected $name = 'desktop_route';

    /**
     * 得到布局容器名称
     * @param $value
     * @param $data
     * @return null
     * @throws Exception
     */
    public function getLayoutNameAttr($value, $data)
    {
        $route = SingletonFactory::getInstance(RouteService::class);
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
        $routeService = SingletonFactory::getInstance(RouteService::class);
        return $routeService->getKeepAliveName($data['keep_alive']);
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
