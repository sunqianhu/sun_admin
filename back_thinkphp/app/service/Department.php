<?php

namespace app\service;

use app\model\Department as DepartmentModel;
use app\model\User as UserModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use think\facade\Cache;

class Department
{
    /**
     * 得到树形部门
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeDepartments()
    {
        $departmentModels = DepartmentModel::field('id, id, department_id, name')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $departmentModel = new DepartmentModel();
        $departmentModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $departmentModel = DepartmentModel::find($id);
        if(empty($departmentModel)){
            throw new Exception('没有找到记录');
        }
        $departmentModel->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function delete($id)
    {
        $departmentModel = DepartmentModel::find($id);
        if(empty($departmentModel)){
            throw new Exception('没有找到记录');
        }
        $departmentModel->delete();
    }

    /**
     * 得到姓名
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

        $name = DepartmentModel::where('id', $id)->value('name');
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
        $names = DepartmentModel::where('id', 'in', $ids)->column('name');
        return implode($glue, $names);
    }

    /**
     * 得到用户
     * @param $id
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getUsersById($id){
        $users = UserModel::where('department_id', $id)->select();
        return $users->toArray();
    }

    /**
     * 通过类型得到部门集合
     * @param $typeId
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getDepartmentsByTypeId($typeId) {
        $departmentModels = DepartmentModel::field('id,name,type_id,department_id')
            ->where('type_id', '=', $typeId)
            ->order('sort', 'asc')
            ->select();
        return $departmentModels->toArray();
    }
}