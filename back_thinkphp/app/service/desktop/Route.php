<?php

namespace app\service\desktop;

use app\model\desktop\Route as RouteModel;
use Exception;

class Route
{
    /**
     * 得到路由集合
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoutes()
    {
        $routeModels = RouteModel::order('sort', 'asc')
            ->select();
        $routes = $routeModels->toArray();

        return $routes;
    }

    /**
     * 得到带名称路径的路由集合
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoutesWithNamePath()
    {
        $routeModels = RouteModel::order('sort', 'asc')
            ->append(['name_path'])
            ->select();
        $routes = $routeModels->toArray();

        return $routes;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $routeModel = new RouteModel();
        $routeModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit($id, $data){
        $routeModel = RouteModel::find($id);
        if(empty($routeModel)){
            throw new Exception('没有找到记录');
        }
        $routeModel->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function delete($id){
        $routeModel = RouteModel::find($id);
        if(empty($routeModel)){
            throw new Exception('没有找到记录');
        }
        $routeModel->delete();
    }
}