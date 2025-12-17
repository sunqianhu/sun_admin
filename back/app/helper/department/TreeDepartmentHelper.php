<?php

namespace app\helper\department;

use app\model\DepartmentModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class TreeDepartmentHelper
{
    /**
     * 得到所有子部门id列表
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllChildrenDepartmentIds($departmentId){
        $departmentModels = DepartmentModel::field('id')
            ->where('department_id', $departmentId)
            ->select();
        $departmentIds = [];
        foreach($departmentModels as $departmentModel){
            $departmentIds[] = $departmentModel->id;
            $departmentIds = array_merge($departmentIds, $this->getAllChildrenDepartmentIds($departmentModel->id));
        }
        return $departmentIds;
    }

    /**
     * 获取所有子部门id列表包括当前部门id
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllChildrenDepartmentIdsWithCurrentId($departmentId)
    {
        $departmentIds[] = $departmentId;
        return array_merge($departmentIds, $this->getAllChildrenDepartmentIds($departmentId));
    }

    /**
     * 得到树形部门
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeDepartment($departmentId)
    {
        $departmentIds = $this->getAllChildrenDepartmentIds($departmentId);
        $departmentIds[] = $departmentId;

        $departmentModels = DepartmentModel::field('id, id, department_id, name')
            ->whereIn('id', $departmentIds)
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');
    }
}