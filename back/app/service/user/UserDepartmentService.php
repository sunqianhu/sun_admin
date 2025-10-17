<?php

namespace app\service\user;

use app\model\UserModel;
use app\service\DepartmentService;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserDepartmentService
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
        $departmentService = new DepartmentService();
        return $departmentService->getBaseDepartment($departmentId);
    }
}