<?php

namespace app\helper\user;

use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserPasswordHelper
{
    /**
     * 修改密码
     * @param $userId
     * @param $password
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function editPassword($userId, $password)
    {
        $userModel = UserModel::find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->password = md5($password);
        $userModel->save();
    }
}