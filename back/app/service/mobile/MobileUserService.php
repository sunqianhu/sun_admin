<?php

namespace app\service\mobile;

use app\model\mobile\PermissionModel;
use app\model\mobile\SessionModel;
use app\service\UserRoleService;
use app\service\UserService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class MobileUserService
{
    /**
     * 下线
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function offLine($id){
        $sessionModels = SessionModel::where('user_id', $id)->select();
        if ($sessionModels->isEmpty()) {
            throw new Exception('没有找到会话记录');
        }
        $sessionModels->delete();
    }
}