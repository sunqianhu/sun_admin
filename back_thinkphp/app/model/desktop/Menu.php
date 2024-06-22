<?php

namespace app\model\desktop;

use app\model\Base;

class Menu extends Base
{
    protected $name = 'desktop_menu';

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
     * 得到权限名称和备注
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
