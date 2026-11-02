<?php
namespace app\model;

use app\helper\DictionaryHelper;
use Exception;
use Sunqianhu\Helper\SingletonFactory;

class OperationLogModel extends BaseModel
{
    protected $name = 'operation_log';

    /**
     * 得到业务码名称
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getResponseBusinessCodeNameAttr($value, $data)
    {
        $dictionaryHelper = SingletonFactory::getInstance(DictionaryHelper::class);
        return $dictionaryHelper->getValue('response_business_code', $data['response_business_code']);
    }

    /**
     * 得到终端名称
     * @param $value
     * @param $data
     * @return string
     * @throws Exception
     */
    public function getTerminalNameAttr($value, $data)
    {
        $dictionaryHelper = SingletonFactory::getInstance(DictionaryHelper::class);
        return $dictionaryHelper->getValue('terminal', $data['terminal']);
    }
}
