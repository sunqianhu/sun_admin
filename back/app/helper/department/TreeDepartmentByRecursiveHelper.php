<?php

namespace app\helper\department;

use app\model\DepartmentModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class TreeDepartmentByRecursiveHelper
{
    /**
     * 得到子孙部门ID列表
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getDescendantDepartmentIds($departmentId){
        $departmentModels = DepartmentModel::field('id')
            ->where('department_id', $departmentId)
            ->select();
        $departmentIds = [];
        foreach($departmentModels as $departmentModel){
            $departmentIds[] = $departmentModel->id;
            $departmentIds = array_merge($departmentIds, $this->getDescendantDepartmentIds($departmentModel->id));
        }
        return $departmentIds;
    }

    /**
     * 获取子孙部门ID列表包括当前部门ID
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getDescendantDepartmentIdsWithCurrentId($departmentId)
    {
        $departmentIds[] = $departmentId;
        return array_merge($departmentIds, $this->getDescendantDepartmentIds($departmentId));
    }

    /**
     * 得到所有的父部门ID列表
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAncestorDepartmentIds($departmentId){
        $departmentIds = [];
        $departmentModel = DepartmentModel::field('id,department_id')->find($departmentId);
        if(!empty($departmentModel) && $departmentModel->department_id){
            $parentDepartmentIds = $this->getAncestorDepartmentIds($departmentModel->department_id);
            $departmentIds = array_merge($parentDepartmentIds, [$departmentModel->department_id]);
        }
        return $departmentIds;
    }

    /**
     * 获取所有父部门ID列表包括当前部门ID列表
     * @param $departmentId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAncestorDepartmentIdsWithCurrentId($departmentId)
    {
        $departmentIds = $this->getAncestorDepartmentIds($departmentId);
        $departmentIds[] = $departmentId;
        return $departmentIds;
    }

    /**
     * 获取部门路径
     * @param $departmentId
     * @return string
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getPath($departmentId)
    {
        $departmentIds = $this->getAncestorDepartmentIdsWithCurrentId($departmentId);
        return '/'.implode('/', $departmentIds);
    }
}