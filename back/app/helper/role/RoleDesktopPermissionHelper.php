<?php

namespace app\helper\role;

use app\model\RoleDesktopPermissionModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RoleDesktopPermissionHelper
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
        try {
            $roleDesktopPermissionModels = RoleDesktopPermissionModel::where('role_id', $roleId)->select();
            $roleDesktopPermissionModels->delete();

            if (!empty($permissionIds)) {
                foreach ($permissionIds as $permissionId) {
                    $roleDesktopPermissionModel = new RoleDesktopPermissionModel();
                    $roleDesktopPermissionModel->save([
                        'role_id' => $roleId,
                        'permission_id' => $permissionId
                    ]);
                }
            }
            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            throw $exception;
        }
    }
}