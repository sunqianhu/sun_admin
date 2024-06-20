<?php

namespace app\model\mobile;

use app\model\Base;
use app\service\Dictionary as DictionaryService;

class Module extends Base
{
    protected $name = 'mobile_module';

    /**
     * 获取接口地址
     * @param $value
     * @return string
     */
    public function getApisAttr($value, $data)
    {
        if(!isset($data['api'])){
            return [];
        }

        $api = str_replace("\r\n", "\n", $data['api']);
        return explode("\n", $api);
    }

    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeNameAttr($value, $data)
    {
        $dictionaryService = new DictionaryService();
        return $dictionaryService->getValue('mobile_module_type', $data['type_id']);
    }

    /**
     * 得到模块名称和备注
     * @param $value
     * @return string
     */
    public function getNameRemarkAttr($value, $data)
    {
        $nameRemark = '';
        if(!empty($data['name'])){
            $nameRemark .= $data['name'];
        }
        if(!empty($data['remark'])){
            $nameRemark .= '（'.$data['remark'].'）';
        }
        return $nameRemark;
    }
}
