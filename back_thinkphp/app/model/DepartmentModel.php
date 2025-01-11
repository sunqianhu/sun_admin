<?php

namespace app\model;

use app\service\Department;

class DepartmentModel extends BaseModel
{
    protected $name = 'department';

    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeNameAttr($value, $data)
    {
        $department = SingletonFactory::getInstance(Department::class);
        return $department->getTypeName($data['type_id']);
    }
}
