<?php

namespace app\helper\role;

use app\model\RoleDesktopMenuModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class DesktopMenuHelper
{
    /**
     * 设置关系
     * @param $roleId
     * @param $menuIds
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updateRelateByMenuIds($roleId, $menuIds)
    {
        Db::startTrans();
        try{
            $this->deleteByRoleId($roleId);

            if (!empty($menuIds)) {
                foreach ($menuIds as $menuId) {
                    $roleDesktopMenuModel = new RoleDesktopMenuModel();
                    $roleDesktopMenuModel->save([
                        'role_id' => $roleId,
                        'menu_id' => $menuId
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
     * 通过角色删除桌面端菜单绑定
     * @param $roleId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByRoleId($roleId)
    {
        $roleDesktopMenuModels = RoleDesktopMenuModel::where('role_id', $roleId)->select();
        $roleDesktopMenuModels->delete();
    }
}
