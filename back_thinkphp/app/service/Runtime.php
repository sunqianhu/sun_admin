<?php
namespace app\service;

use app\model\RuntimeModel;

class Runtime
{
    /**
     * 得知值
     * @param $key
     * @return mixed
     */
    public function getValue($key)
    {
        return RuntimeModel::where('key', $key)->value('value') ?? '';
    }

    /**
     * 设置值
     * @param $key
     * @param $value
     * @return void
     */
    public function setValue($key, $value){
        $runtime = RuntimeModel::where('key', $key)->findOrEmpty();
        $runtime->key = $key;
        $runtime->value = $value;
        $runtime->save();
    }
}