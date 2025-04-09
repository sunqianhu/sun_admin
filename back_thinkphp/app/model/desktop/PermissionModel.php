<?php

namespace app\model\desktop;

use app\model\BaseModel;

class PermissionModel extends BaseModel
{
    protected $name = 'desktop_permission';

    /**
     * 获取接口地址
     * @param $value
     * @return array
     */
    public function getApisAttr($value, $data)
    {
        if(!isset($data['api_string'])){
            return [];
        }

        $apiString = str_replace("\r\n", "\n", $data['api_string']);
        $apis = explode("\n", $apiString);
        $apis = array_filter($apis, function($value) {
            return $value !== '';
        });
        return array_unique($apis);
    }

    /**
     * 名称键
     * @param $value
     * @param $data
     * @return string
     */
    public function getNameKeyAttr($value, $data)
    {
        $nameKey = $data['name'];
        if(isset($data['key']) && $data['key'] !== ''){
            $nameKey = $data['name'].'（'.$data['key'].'）';
        }
        return $nameKey;
    }
}
