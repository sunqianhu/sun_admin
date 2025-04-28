<?php

namespace app\service;

use app\model\DepartmentModel;
use app\model\UserModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use Sunqianhu\Helper\SingletonFactory;
use think\facade\Cache;

class DepartmentService
{
    /**
     * 得到树形部门
     * @return array
     */
    public function getTreeDepartment()
    {
        $departmentModels = DepartmentModel::field('id, id, department_id, name')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');
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
     * 通过类型得到部门列表
     * @param $type
     * @return array
     */
    public function getDepartmentsByType($type) {
        $departmentModels = DepartmentModel::field('id,name,type,department_id')
            ->where('type', $type)
            ->order('sort', 'asc')
            ->select();
        return $departmentModels->toArray();
    }

    /**
     * 得到分类名称
     * @param $type
     * @return mixed
     * @throws Exception
     */
    public function getTypeName($type)
    {
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('department_type', $type);
    }
}