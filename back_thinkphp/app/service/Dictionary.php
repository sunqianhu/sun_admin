<?php

namespace app\service;

use app\model\Dictionary as DictionaryModel;
use Exception;
use think\facade\Cache;

class Dictionary
{
    /**
     * @var int 有效期
     */
    private $expire = 600;

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $dictionaryModel = new DictionaryModel();
        $dictionaryModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $dictionaryModel = DictionaryModel::find($id);
        if(empty($dictionaryModel)){
            throw new Exception('没有找到记录');
        }
        $dictionaryModel->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function delete($id)
    {
        $dictionaryModel = DictionaryModel::find($id);
        if(empty($dictionaryModel)){
            throw new Exception('没有找到记录');
        }
        $dictionaryModel->delete();
    }

    /**
     * 获取字典集合
     * @param $type
     * @return array
     */
    public function getList($type)
    {
        $cacheKey = 'dictionary_' . $type;
        $list = Cache::get($cacheKey);
        if (!empty($list)) {
            return $list;
        }

        $dictionaryModels = DictionaryModel::where('type', '=', $type)
            ->field('key,value')
            ->order('sort', 'asc')
            ->select();
        $list = $dictionaryModels->toArray();
        Cache::set($cacheKey, $list, $this->expire);

        return $list;
    }

    /**
     * 获取值
     * @param $type
     * @param $key
     * @return void
     */
    public function getValue($type, $key)
    {
        $cacheKey = 'dictionary_' . $type . '_' . $key;
        $value = Cache::get($cacheKey);
        if (!empty($value)) {
            return $value;
        }

        $value = DictionaryModel::field('value')
            ->where('type', '=', $type)
            ->where('key', '=', $key)
            ->order('sort', 'asc')
            ->value('value');
        Cache::set($cacheKey, $value, $this->expire);

        return $value;
    }

    /**
     * 获取值串
     * @param $type
     * @param $keys
     * @return void
     */
    public function getValueString($type, $keys, $glue = '，')
    {
        $keyString = implode(',', $keys);
        $cacheKey = 'dictionary_' . $type . '_' . $keyString;
        $valueString = Cache::get($cacheKey);
        if (!empty($valueString)) {
            return $valueString;
        }

        $values = DictionaryModel::where('type', '=', $type)
            ->where('key', 'in', $keyString)
            ->field('value')
            ->order('sort', 'asc')
            ->column('value');
        $valueString = implode($glue, $values);
        Cache::set($cacheKey, $valueString, $this->expire);

        return $valueString;
    }
}