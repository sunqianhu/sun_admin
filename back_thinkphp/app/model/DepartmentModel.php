<?php

namespace app\model;

use app\service\DictionaryService;
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
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('department_type', $data['type']);
    }
}
