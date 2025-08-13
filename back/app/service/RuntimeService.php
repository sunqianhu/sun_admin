<?php
namespace app\service;

use app\model\RuntimeModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class RuntimeService
{
    /**
     * 得知值
     * @param $key
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getValue($key)
    {
        $runtimeModel = RuntimeModel::field('value')
            ->where('key', $key)
            ->find();
        if(empty($runtimeModel)){
            throw new Exception('没有找到运行时记录');
        }
        return $runtimeModel->value;
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