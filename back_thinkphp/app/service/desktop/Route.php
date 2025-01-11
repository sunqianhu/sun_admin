<?php

namespace app\service\desktop;

use app\model\desktop\RouteModel;
use app\service\Curd;
use app\service\Dictionary;
use app\service\SingletonFactory;
use Exception;

class Route extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(RouteModel::class);
    }

    /**
     * 得到路由列表
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoutes()
    {
        $routes = RouteModel::order('sort', 'asc')
            ->select();
        return $routes->toArray();
    }

    /**
     * 得到名称路径的路由列表
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getNamePathRoutes()
    {
        $routes = RouteModel::order('sort', 'asc')
            ->append(['name_path'])
            ->select();
        return $routes->toArray();
    }


    /**
     * 得到布局名称
     * @param $layout
     * @return mixed
     * @throws Exception
     */
    public function getLayoutName($layout)
    {
        $dictionary = SingletonFactory::getInstance(Dictionary::class);
        return $dictionary->getValue('desktop_route_layout', $layout);
    }

    /**
     * 得到保活名称
     * @param $layout
     * @return mixed
     * @throws Exception
     */
    public function getKeepAliveName($layout)
    {
        $dictionary = SingletonFactory::getInstance(Dictionary::class);
        return $dictionary->getValue('desktop_route_keep_alive', $layout);
    }
}