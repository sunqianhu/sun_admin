<?php

namespace app\service;

use app\model\Department as DepartmentModel;
use think\facade\Cache;

class Department
{
    public function add($data)
    {

    }

    public function edit()
    {

    }

    public function delete()
    {

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
}