<?php

namespace app\service\user;

use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserStatusService
{
    /**
     * 修改状态
     * @param $id
     * @param $status
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException|Exception
     */
    public function editStatus($id, $status)
    {
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->status = $status;
        return $userModel->save();
    }
}