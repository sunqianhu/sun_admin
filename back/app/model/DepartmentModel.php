<?php

namespace app\model;

use app\helper\DictionaryHelper;
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
        $dictionaryHelper = SingletonFactory::getInstance(DictionaryHelper::class);
        return $dictionaryHelper->getValue('department_type', $data['type']);
    }
}
