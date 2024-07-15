<?php

namespace app\model\desktop;

use app\model\Base;

class Menu extends Base
{
    protected $name = 'desktop_menu';

    /**
     * 名称网址
     * @param $value
     * @param $data
     * @return string
     */
    public function getNameUrlAttr($value, $data)
    {
        $nameUrl = $data['name'];
        if(isset($data['url']) && $data['url'] !== ''){
            $nameUrl = $data['name'].'（'.$data['url'].'）';
        }
        return $nameUrl;
    }
}
