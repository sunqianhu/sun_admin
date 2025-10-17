<?php
namespace app\model;

use app\service\DictionaryService;
use Exception;
use Sunqianhu\Helper\SingletonFactory;

class OperationLogModel extends BaseModel
{
    protected $name = 'operation_log';

    /**
     * 得到类型名称
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getTerminalNameAttr($value, $data)
    {
        $dictionaryService = SingletonFactory::getInstance(DictionaryService::class);
        return $dictionaryService->getValue('operation_terminal', $data['terminal']);
    }

}