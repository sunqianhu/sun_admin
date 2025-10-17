<?php

namespace app\service\user;

use app\model\UserRoleModel;

class UserRoleService
{
    /**
     * 得到角色id列表
     * @param $userId
     * @return array
     */
    public function getRoleIds($userId)
    {
        return UserRoleModel::where('user_id', $userId)
            ->group('role_id')
            ->column('role_id');
    }
}