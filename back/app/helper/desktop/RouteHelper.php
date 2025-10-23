<?php

namespace app\helper\desktop;

use app\model\desktop\RouteModel;
use app\helper\DictionaryHelper;
use Sunqianhu\Helper\SingletonFactory;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class RouteHelper
{
    /**
     * 得到路由列表
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getRoutes()
    {
        $routeModels = RouteModel::order('sort', 'asc')
            ->select();
        return $routeModels->toArray();
    }
}