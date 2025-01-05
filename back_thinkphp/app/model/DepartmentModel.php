<?php

namespace app\model;

use app\service\Dictionary;

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
        $dictionary = new Dictionary();
        return $dictionary->getValue('department_type', $data['type_id']);
    }
}
