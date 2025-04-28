<?php

namespace app\service\desktop;

use app\model\desktop\RouteModel;
use app\service\DictionaryService;
use Sunqianhu\Helper\SingletonFactory;
use Exception;

class RouteService
{
    /**
     * 得到路由列表
     * @return array
     */
    public function getRoutes()
    {
        $routeModels = RouteModel::order('sort', 'asc')
            ->select();
        return $routeModels->toArray();
    }

    /**
     * 得到布局名称
     * @param $layout
     * @return mixed
     * @throws Exception
     */
    public function getLayoutName($layout)
    {
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('desktop_route_layout', $layout);
    }

    /**
     * 得到保活名称
     * @param $layout
     * @return mixed
     * @throws Exception
     */
    public function getKeepAliveName($layout)
    {
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('desktop_route_keep_alive', $layout);
    }
}