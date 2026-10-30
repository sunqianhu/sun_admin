<?php

namespace app\helper\user;

use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use Throwable;

class UserPasswordHelper
{
    /**
     * 检测密码
     * @param $userId
     * @param string $password
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function checkPassword($userId, $password): bool
    {
        $userModel = UserModel::field('id,password')->where('id', $userId)->find();
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }

        return password_verify($password, $userModel->password);
    }

    /**
     * 修改密码
     * @param $userId
     * @param $password
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception|Throwable
     */
    public function editPassword($userId, $password)
    {
        $userModel = UserModel::find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->password = password_hash($password, PASSWORD_DEFAULT);
        $userModel->save();
    }
}
