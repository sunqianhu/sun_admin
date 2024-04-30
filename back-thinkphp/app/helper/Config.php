<?php
namespace app\helper;

use app\model\Config as ConfigModel;

class Config
{
    /**
     * 得知值
     * @param $key 键
     * @return mixed
     */
    public function getValue($key)
    {
        return ConfigModel::where('key', $key)->value('value');
    }

    /**
     * 设置值
     * @param $key 键
     * @param $value 值
     * @return void
     */
    public function setValue($key, $value){
        $configModel = ConfigModel::where('key', $key)->find();
        if($configModel == null){
            $configModel = new ConfigModel();
        }
        $configModel->key = $key;
        $configModel->value = $value;
        $configModel->save();
    }
}