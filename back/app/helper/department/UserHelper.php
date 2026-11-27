<?php

namespace app\helper\department;

use app\model\UserModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserHelper
{
    /**
     * 得到用户列表
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getUsers($departmentId){
        $userModels = UserModel::field('id,name,department_id')
            ->where('department_id', $departmentId)
            ->select();
        return $userModels->toArray();
    }

    /**
     * 是否存在用户
     * @param $departmentId
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistUsers($departmentId)
    {
        $userModel = UserModel::field('id')
            ->where('department_id', $departmentId)
            ->limit(0,1)
            ->find();
        if(empty($userModel)){
            return false;
        }
        return true;
    }
}