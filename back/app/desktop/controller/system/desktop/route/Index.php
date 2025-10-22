<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\RouteModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Index extends Base
{
    /**
     * 得到路由列表
     */
    public function getRoutes()
    {
        $get = $this->request->get(['name']);
        $query = RouteModel::field('id,name,key,path,component_path,layout,keep_alive,sort');
        if (isset($get['name'])) {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('sort', 'asc')
            ->append(['layout_name', 'keep_alive_name']);
        $routeModels = $query->select();
        $routes = $routeModels->toArray();

        return $this->getSuccessResponse('获取成功', $routes);
    }

    /**
     * 删除
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $routeModel = RouteModel::find($id);
        if(empty($routeModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $routeModel->delete();
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}