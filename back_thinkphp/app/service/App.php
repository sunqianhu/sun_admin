<?php

namespace app\service;

use think\facade\Config;

class App
{
    /**
     * 得到url
     * @param string $path 路径
     */
    public function getUrl($path)
    {
        if($path === ''){
            return '';
        }

        return Config::get('app.access_prefix') . $path;
    }
}