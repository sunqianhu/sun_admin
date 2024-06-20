<?php

namespace app\model\desktop;

use app\model\Base;

class Module extends Base
{
    protected $name = 'desktop_module';

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
