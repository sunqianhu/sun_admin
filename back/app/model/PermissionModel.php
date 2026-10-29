<?php

namespace app\model;



class PermissionModel extends BaseModel
{
    protected $name = 'permission';

    /**
     * 获取接口地址
     * @param $value
     * @param $data
     * @return array
     */
    public function getApisAttr($value, $data)
    {
        if(!isset($data['apis_string'])){
            return [];
        }

        $apis = preg_split('/\r\n|\r|\n/', $data['apis_string'] ?? '');
        $apis = array_map(function ($api) {
            return ltrim(trim($api), '/');
        }, $apis);
        $apis = array_filter($apis, function($value) {
            return $value !== '';
        });
        return array_unique($apis);
    }
}
