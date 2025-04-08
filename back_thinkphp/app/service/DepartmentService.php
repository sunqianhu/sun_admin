<?php

namespace app\service;

use app\model\DepartmentModel;
use app\model\UserModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use think\facade\Cache;

class DepartmentService extends CrudService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(DepartmentModel::class);
    }

    /**
     * 得到树形部门
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeDepartment()
    {
        $departments = DepartmentModel::field('id, id, department_id, name')
            ->order('sort', 'asc')
            ->select();
        $departmentArrays = $departments->toArray();
        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($departmentArrays, 'id', 'department_id', 'children');
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
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getUsers($id){
        $users = UserModel::field('id,name,department_id')
            ->where('department_id', $id)
            ->select();
        return $users->toArray();
    }

    /**
     * 通过类型得到部门列表
     * @param $type
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTypeDepartments($type) {
        $departments = DepartmentModel::field('id,name,type,department_id')
            ->where('type', $type)
            ->order('sort', 'asc')
            ->select();
        return $departments->toArray();
    }

    /**
     * 得到分类名称
     * @param $type
     * @return mixed
     * @throws Exception
     */
    public function getTypeName($type)
    {
        $dictionary = SingletonFactoryService::getInstance(DictionaryService::class);
        return $dictionary->getValue('department_type', $type);
    }
}