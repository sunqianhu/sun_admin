<?php

namespace app\helper\role;

use app\model\RoleDesktopRouteModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RoleDesktopRouteHelper
{
    /**
     * 设置关系
     * @param $roleId
     * @param $routeIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateRelateByRouteIds($roleId, $routeIds)
    {
        Db::startTrans();
        try{
            $this->deleteByRoleId($roleId);

            if (!empty($routeIds)) {
                foreach ($routeIds as $routeId) {
                    $roleDesktopRouteModel = new RoleDesktopRouteModel();
                    $roleDesktopRouteModel->save([
                        'role_id' => $roleId,
                        'route_id' => $routeId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 通过角色删除桌面端路由绑定
     * @param $roleId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByRoleId($roleId)
    {
        $roleDesktopRouteModels = RoleDesktopRouteModel::where('role_id', $roleId)->select();
        $roleDesktopRouteModels->delete();
    }
}
