<?php

namespace app\service;

use app\model\RoleDesktopPermissionModel;
use app\model\RoleMobilePermissionModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RoleMobilePermissionService
{
    /**
     * 设置关系
     * @param $roleId
     * @param $permissionIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function setRelation($roleId, $permissionIds)
    {
        Db::startTrans();
        try{
            $roleMobilePermissionModels = RoleMobilePermissionModel::where('role_id', $roleId)->select();
            $roleMobilePermissionModels->delete();

            if (!empty($permissionIds)) {
                foreach ($permissionIds as $permissionId) {
                    $roleMobilePermissionModel = new RoleMobilePermissionModel();
                    $roleMobilePermissionModel->save([
                        'role_id' => $roleId,
                        'permission_id' => $permissionId
                    ]);
                }
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }
}