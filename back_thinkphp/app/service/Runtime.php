<?php
namespace app\service;

use app\model\Runtime as RuntimeModel;

class Runtime
{
    /**
     * 得知值
     * @param $key
     * @return mixed
     */
    public function getValue($key)
    {
        return RuntimeModel::where('key', $key)->value('value');
    }

    /**
     * 设置值
     * @param $key
     * @param $value
     * @return void
     */
    public function setValue($key, $value){
        $runtimeModel = RuntimeModel::where('key', $key)->find();
        if(empty($runtimeModel)){
            $runtimeModel = new RuntimeModel();
        }
        $runtimeModel->key = $key;
        $runtimeModel->value = $value;
        $runtimeModel->save();
    }
}