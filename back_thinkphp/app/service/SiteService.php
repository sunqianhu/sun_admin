<?php

namespace app\service;

use think\facade\Config;

class SiteService
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
        return Config::get('site.root_path') . $path;
    }
}