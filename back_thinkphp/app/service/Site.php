<?php

namespace app\service;

use Exception;
use think\facade\Config;

class Site
{
    /**
     * 得到url
     * @param string $path 路径
     */
    public function getUrl($path)
    {
        return Config::get('site.access_prefix') . $path;
    }

    /**
     * 得到全路径
     * @param $path
     * @return string
     */
    public function getFullPath($path){
        if($path === ''){
            throw new Exception('路径不能为空');
        }
        return Config::get('site.root_path') . $path;
    }
}