<?php

namespace app\service\desktop;

use app\model\desktop\RouteModel;
use app\service\Curd;
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
}