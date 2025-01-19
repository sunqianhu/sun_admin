<?php

namespace app\model;

use app\service\DepartmentService;
use app\service\SingletonFactoryService;

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
        $department = SingletonFactoryService::getInstance(DepartmentService::class);
        return $department->getTypeName($data['type']);
    }
}
