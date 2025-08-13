<?php

namespace app\model\desktop;

use app\model\BaseModel;
use app\service\desktop\RouteService;
use app\service\DictionaryService;
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
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('desktop_route_layout', $data['layout']);
    }

    /**
     * 得到保活名称
     * @param $value
     * @param $data
     * @return null
     * @throws Exception
     */
    public function getKeepAliveNameAttr($value, $data)
    {
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('desktop_route_keep_alive', $data['keep_alive']);
    }
}
