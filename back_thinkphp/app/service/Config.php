<?php
namespace app\service;

use app\model\ConfigModel;

class Config
{
    /**
     * 得知值
     * @param $key
     * @return mixed
     */
    public function getValue($key)
    {
        return ConfigModel::where('key', $key)->value('value') ?? '';
    }

    /**
     * 设置值
     * @param $key
     * @param $value
     * @return void
     */
    public function setValue($key, $value){
        $configModel = ConfigModel::where('key', $key)->findOrEmpty();
        $configModel->key = $key;
        $configModel->value = $value;
        $configModel->save();
    }
}