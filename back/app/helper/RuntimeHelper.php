<?php
namespace app\helper;

use app\model\RuntimeModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class RuntimeHelper
{
    /**
     * 得知值
     * @param $key
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
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
        $runtimeModel = RuntimeModel::where('key', $key)->findOrEmpty();
        $runtimeModel->key = $key;
        $runtimeModel->value = $value;
        $runtimeModel->save();
    }
}