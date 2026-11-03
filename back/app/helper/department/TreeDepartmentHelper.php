<?php

namespace app\helper\department;

use app\model\DepartmentModel;
use Sunqianhu\Helper\Arr;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class TreeDepartmentHelper
{
    /**
     * 得到子孙部门ID列表
     * @param $departmentId
     * @return array
     */
    public function getDescendantDepartmentIds($departmentId){
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        return DepartmentModel::field('id')
            ->where('path', 'like', $path.'/%')
            ->column('id');
    }

    /**
     * 获取子孙部门ID列表包括当前部门ID
     * @param $departmentId
     * @return array
     */
    public function getDescendantDepartmentIdsWithCurrentId($departmentId)
    {
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        return DepartmentModel::field('id')
            ->where(function ($query) use ($path) {
                $query->where('path', $path)
                    ->whereOr('path', 'like', $path.'/%');
            })
            ->column('id');
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
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        $departmentModels = DepartmentModel::field('id,name,department_id,type,path')
            ->where(function ($query) use ($path) {
                $query->where('path', $path)
                    ->whereOr('path', 'like', $path.'/%');
            })
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arr = new Arr();
        return $arr->toTree($departments, 'id', 'department_id', 'children');
    }

    /**
     * 得到祖先部门ID列表
     * @param $departmentId
     * @return array
     */
    public function getAncestorDepartmentIds($departmentId){
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        $departmentIds = explode('/', $path);
        $departmentIds = array_unique($departmentIds);
        if(empty($departmentIds)){
            return [];
        }
        array_pop($departmentIds);
        return $departmentIds;
    }

    /**
     * 获取所有父部门ID列表包括当前部门ID列表
     * @param $departmentId
     * @return array
     */
    public function getAncestorDepartmentIdsWithCurrentId($departmentId)
    {
        $departmentPathHelper = new DepartmentPathHelper();
        $path = $departmentPathHelper->getPath($departmentId);

        $departmentIds = explode('/', $path);
        $departmentIds = array_unique($departmentIds);
        return $departmentIds;
    }
}
