<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\Route as RouteModel;
use app\service\desktop\Route as RouteService;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到路由集合
     */
    public function getRoutes()
    {
        $get = $this->request->get(['name']);
        $query = RouteModel::field('id,name,key,path,component_path,layout,keep_alive,sort');
        if (isset($get['name'])) {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('sort', 'asc')
            ->append(['layout_name', 'keep_alive_name']);
        $routeModels = $query->select();
        $routes = $routeModels->toArray();

        return $this->success('获取成功', $routes);
    }

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $routeService = new RouteService();
        try{
            $routeService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}