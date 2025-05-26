<?php

namespace app\service;

use app\model\DepartmentModel;
use app\model\UserModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use Sunqianhu\Helper\SingletonFactory;
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
    public function getNameString($ids, $glue = '，')
    {
        if (empty($ids)) {
            return '';
        }
        $names = DepartmentModel::whereIn('id', $ids)->column('name');
        return implode($glue, $names);
    }

    /**
     * 得到用户列表
     * @param $id
     * @return array
     */
    public function getUsers($id){
        $userModels = UserModel::field('id,name,department_id')
            ->where('department_id', $id)
            ->select();
        return $userModels->toArray();
    }

    /**
     * 是否存在用户
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistUsers($id)
    {
        $UserModel = UserModel::field('id')
            ->where('department_id', $id)
            ->limit(0,1)
            ->find();
        if(empty($UserModel)){
            return false;
        }
        return true;
    }

    /**
     * 得到所有子部门id列表
     * @param $id
     * @return array
     */
    public function getAllChildrenIds($id){
        $departmentModels = DepartmentModel::field('id')
            ->where('department_id', $id)
            ->select();
        $ids = [];
        foreach($departmentModels as $departmentModel){
            $ids[] = $departmentModel->id;
            $ids = array_merge($ids, $this->getAllChildrenIds($departmentModel->id));
        }
        return $ids;
    }

    /**
     * 得到树形部门
     * @return array
     */
    public function getTreeDepartment($id)
    {
        $ids = $this->getAllChildrenIds($id);
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
     * 得到是否存在子部门
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getIsExistChildren($id){
        $departmentModel = DepartmentModel::field('id')
            ->where('menu_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($departmentModel)){
            return true;
        }
        return false;
    }

    /**
     * 得到是否存在部门或用户
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getIsExistDepartmentsOrUsers($id)
    {
        if($this->getIsExistChildren($id) || $this->isExistUsers($id)){
            return true;
        }
        return false;
    }
}