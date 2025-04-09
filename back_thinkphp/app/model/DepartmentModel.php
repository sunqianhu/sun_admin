<?php

namespace app\model;

use app\service\DepartmentService;
use Sunqianhu\Helper\SingletonFactory;

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
        $departmentService = SingletonFactory::getInstance(DepartmentService::class);
        return $departmentService->getTypeName($data['type']);
    }
}
