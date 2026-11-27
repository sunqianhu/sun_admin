<?php

namespace app\helper\role;

use app\model\UserRoleModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserHelper
{
    /**
     * 通过角色删除用户绑定
     * @param $roleId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByRoleId($roleId)
    {
        $userRoleModels = UserRoleModel::where('role_id', $roleId)->select();
        $userRoleModels->delete();
    }
}
