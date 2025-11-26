<?php
namespace app\model;

use app\helper\DictionaryHelper;
use Exception;
use Sunqianhu\Helper\SingletonFactory;

class LoginLogModel extends BaseModel
{
    protected $name = 'login_log';

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