<?php

namespace app\helper\user\data_scope\global_department_access;

use app\helper\department\DepartmentPathHelper;
use app\helper\user\UserDataScopeHelper;
use app\model\DepartmentModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class TreeDepartmentHelper
{
    /**
     * 得到树形部门
     * @param $userId
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeDepartment($userId, $departmentId)
    {
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        $query = DepartmentModel::field('id,name,department_id,type,path')
            ->where('path', 'like', $path.'%');

        $userDataScopeHelper = new UserDataScopeHelper();
        $query = $userDataScopeHelper->buildQueryConstraint($userId, 'global_department_access', $query, 'id', '');

        $query->order('sort', 'asc');
        $departmentModels = $query->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');
    }
}