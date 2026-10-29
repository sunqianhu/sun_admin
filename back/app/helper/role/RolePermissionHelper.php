<?php

namespace app\helper\role;

use app\model\RolePermissionModel;
use app\model\PermissionModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RolePermissionHelper
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
            $permissionIds = array_values(array_unique($permissionIds));
            if (!empty($permissionIds) && (int) PermissionModel::whereIn('id', $permissionIds)->count() !== count($permissionIds)) {
                throw new Exception('包含不存在的权限');
            }
            $rolePermissionModels = RolePermissionModel::where('role_id', $roleId)->select();
            $rolePermissionModels->delete();

            if (!empty($permissionIds)) {
                foreach ($permissionIds as $permissionId) {
                    $rolePermissionModel = new RolePermissionModel();
                    $rolePermissionModel->save([
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
