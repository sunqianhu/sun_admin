<?php

namespace app\service;

use app\model\DepartmentModel;
use app\service\department\DepartmentUserService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;

class DepartmentService
{
    /**
     * 得到id
     * @param $name
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getId($name)
    {
        $departmentModel = DepartmentModel::field('id')
            ->where('name', $name)
            ->find();
        if(empty($departmentModel)){
            throw new Exception('没有找到部门');
        }
        return $departmentModel->id;
    }

    /**
     * 得到名称
     * @param $id
     * @return mixed
     */
    public function getName($id)
    {
        $key = 'department_name_'.$id;
        $name = Cache::get($key);
        if($name !== null){
            return $name;
        }

        $name = DepartmentModel::where('id', $id)->value('name') ?? '';
        Cache::set($key, $name, 600);
        return $name;
    }

    /**
     * 得到名称字符串
     * @param $ids
     * @param $glue
     * @return string
     */
    public function getNamesString($ids, $glue = '，')
    {
        if (empty($ids)) {
            return '';
        }
        $names = DepartmentModel::whereIn('id', $ids)->column('name');
        return implode($glue, $names);
    }

    /**
     * 得到所有子部门id列表
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllChildrenDepartmentIds($id){
        $departmentModels = DepartmentModel::field('id')
            ->where('department_id', $id)
            ->select();
        $ids = [];
        foreach($departmentModels as $departmentModel){
            $ids[] = $departmentModel->id;
            $ids = array_merge($ids, $this->getAllChildrenDepartmentIds($departmentModel->id));
        }
        return $ids;
    }

    /**
     * 获取所有子部门id列表包括当前部门id
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllChildrenDepartmentIdsWithCurrentId($id)
    {
        $ids[] = $id;
        return array_merge($ids, $this->getAllChildrenDepartmentIds($id));
    }

    /**
     * 得到树形部门
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeDepartment($id)
    {
        $ids = $this->getAllChildrenDepartmentIds($id);
        $ids[] = $id;

        $departmentModels = DepartmentModel::field('id, id, department_id, name')
            ->whereIn('id', $ids)
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');
    }

    /**
     * 是否存在子部门
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistDepartments($id){
        $departmentModel = DepartmentModel::field('id')
            ->where('department_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($departmentModel)){
            return true;
        }
        return false;
    }

    /**
     * 得到子部门
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getDepartments($id)
    {
        $departmentModels = DepartmentModel::field('id,name,department_id,type')
            ->where('department_id', $id)
            ->order('sort', 'asc')
            ->select();
        return $departmentModels->toArray();
    }

    /**
     * 是否存在部门或用户
     * @param $departmentId
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistDepartmentsOrUsers($departmentId)
    {
        $departmentUserService = new DepartmentUserService();
        if($this->isExistDepartments($departmentId) || $departmentUserService->isExistUsers($departmentId)){
            return true;
        }
        return false;
    }

    /**
     * 得到基本的部门信息
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function getBaseDepartment($id)
    {
        $departmentModel = DepartmentModel::field('id,name,department_id,type')
            ->find($id);
        if(empty($departmentModel)){
            throw new Exception('没有找到部门');
        }
        return $departmentModel->toArray();
    }
}