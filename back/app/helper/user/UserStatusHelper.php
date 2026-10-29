<?php

namespace app\helper\user;

use app\helper\SessionHelper;
use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class UserStatusHelper
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
        return Db::transaction(function () use ($userModel, $id, $status) {
            $userModel->status = $status;
            $result = $userModel->save();

            if ((int) $status === 0) {
                $sessionHelper = new SessionHelper();
                $sessionHelper->deleteByUserId($id);
            }

            return $result;
        });
    }
}
