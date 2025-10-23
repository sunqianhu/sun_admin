<?php

namespace app\helper\user;

use app\model\UserModel;
use app\helper\DepartmentHelper;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserDepartmentHelper
{
    /**
     * 得到部门id
     * @param $userId
     * @return int
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function getDepartmentId($userId)
    {
        $userModel = UserModel::field('department_id')->find($userId);
        if(empty($userModel)){
            throw new Exception('没有找到用户记录');
        }
        return $userModel->department_id;
    }

    /**
     * 获取基本的部门信息
     * @param $userId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getBaseDepartment($userId)
    {
        $departmentId = $this->getDepartmentId($userId);
        $departmentHelper = new DepartmentHelper();
        return $departmentHelper->getBaseDepartment($departmentId);
    }
}