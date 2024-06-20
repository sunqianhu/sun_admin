<?php

namespace app\model;

use app\service\Dictionary as DictionaryService;

class Department extends Base
{
    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeNameAttr($value, $data)
    {
        $dictionaryService = new DictionaryService();
        return $dictionaryService->getValue('department_type', $data['type_id']);
    }
}
