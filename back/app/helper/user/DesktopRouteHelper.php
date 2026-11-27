<?php

namespace app\helper\user;

use app\model\desktop\RouteModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class DesktopRouteHelper
{
    /**
     * 得到路由
     * @param $userId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getRoutes($userId){
        $roleHelper = new RoleHelper();
        $roleIds = $roleHelper->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $routeModels = RouteModel::alias('r')
            ->join('role_desktop_route rdr', 'r.id = rdr.route_id')
            ->field('r.*')
            ->where('rdr.role_id', 'in', $roleIds)
            ->order('r.sort', 'asc')
            ->select();
        $routes = [];
        foreach($routeModels as $routeModel){
            $route = [
                'path'=>$routeModel->path,
                'name'=>$routeModel->key,
                'component_path'=>$routeModel->component_path,
                'meta'=>[
                    'name'=>$routeModel->name,
                    'keep_alive'=>$routeModel->keep_alive,
                    'layout'=>$routeModel->layout,
                ]
            ];
            $routes[] = $route;
        }
        return $routes;
    }
}
