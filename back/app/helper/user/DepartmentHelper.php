<?php

namespace app\helper\user;

use app\model\UserModel;
use app\helper\DepartmentHelper as BaseDepartmentHelper;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;

class DepartmentHelper
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
        $cacheKey = 'user_department_id_'.$userId;
        $cacheTtl = 600;
        $departmentId = Cache::get($cacheKey);
        if ($departmentId !== null) {
            return $departmentId;
        }

        $userModel = UserModel::field('department_id')->find($userId);
        if(empty($userModel)){
            throw new Exception('没有找到用户记录');
        }
        $departmentId = $userModel->department_id;
        Cache::set($cacheKey, $departmentId, $cacheTtl);

        return $departmentId;
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
        $baseDepartmentHelper = new BaseDepartmentHelper();
        return $baseDepartmentHelper->getBaseDepartment($departmentId);
    }
}
