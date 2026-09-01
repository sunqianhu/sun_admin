<?php

namespace app\helper;

use app\model\DictionaryModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;

class DictionaryHelper
{
    /**
     * @var int 有效期
     */
    private int $expire = 600;

    /**
     * 获取字典列表
     * @param $type
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getList($type)
    {
        $cacheKey = 'dictionary_' . $type;
        $list = Cache::get($cacheKey);
        if ($list !== null) {
            return $list;
        }

        $dictionaryModels = DictionaryModel::where('type', $type)
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
     * @throws Exception
     */
    public function getValue($type, $key)
    {
        $cacheKey = 'dictionary_value_' . $type . '_' . $key;
        $value = Cache::get($cacheKey);
        if ($value !== null) {
            return $value;
        }

        $dictionaryModel = DictionaryModel::field('value')
            ->where('type', $type)
            ->where('key', $key)
            ->order('sort', 'asc')
            ->find();
        if(empty($dictionaryModel)){
            throw new Exception('没有找到字典记录');
        }
        $value = $dictionaryModel->value;
        Cache::set($cacheKey, $value, $this->expire);

        return $value;
    }

    /**
     * 获取值串
     * @param $type
     * @param $keys
     * @param string $glue
     * @return string
     */
    public function getValuesString($type, $keys, string $glue = '，')
    {
        $keyString = implode(',', $keys);
        $cacheKey = 'dictionary_' . $type . '_' . str_replace(',', '_', $keyString);
        $valueString = Cache::get($cacheKey);
        if ($valueString !== null) {
            return $valueString;
        }

        $values = DictionaryModel::where('type', $type)
            ->where('key', 'in', $keyString)
            ->field('value')
            ->order('sort', 'asc')
            ->column('value');
        $valuesString = implode($glue, $values);
        Cache::set($cacheKey, $valuesString, $this->expire);

        return $valuesString;
    }

    /**
     * @throws ModelNotFoundException
     * @throws DataNotFoundException
     * @throws DbException
     */
    public function getKey($type, $value)
    {
        $cacheKey = 'dictionary_key_' . $type . '_' . md5($value);
        $key = Cache::get($cacheKey);
        if ($key !== null) {
            return $key;
        }

        $dictionaryModel = DictionaryModel::field('key')
            ->where('type', $type)
            ->where('value', $value)
            ->order('sort', 'asc')
            ->find();
        if(empty($dictionaryModel)){
            throw new Exception('没有找到字典记录');
        }
        $key = $dictionaryModel->key;
        Cache::set($cacheKey, $key, $this->expire);

        return $key;
    }
}