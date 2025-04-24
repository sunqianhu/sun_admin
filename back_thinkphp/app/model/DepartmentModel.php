<?php

namespace app\model;

use app\service\DepartmentService;
use Exception;
use Sunqianhu\Helper\SingletonFactory;

class DepartmentModel extends BaseModel
{
    protected $name = 'department';

    /**
     * 得到类型名称
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getTypeNameAttr($value, $data)
    {
        $departmentService = SingletonFactory::getInstance(DepartmentService::class);
        return $departmentService->getTypeName($data['type']);
    }
}
