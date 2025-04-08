<?php

namespace app\service;

use app\model\DictionaryModel;
use Exception;
use think\facade\Cache;

class DictionaryService extends CrudService
{
    /**
     * @var int 有效期
     */
    private $expire = 600;

    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(DictionaryModel::class);
    }

    /**
     * 获取字典列表
     * @param $type
     * @return array
     */
    public function getList($type)
    {
        $cacheKey = 'dictionary_' . $type;
        $list = Cache::get($cacheKey);
        if ($list !== null) {
            return $list;
        }

        $dictionarys = DictionaryModel::where('type', '=', $type)
            ->field('key,value')
            ->order('sort', 'asc')
            ->select();
        $list = $dictionarys->toArray();
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
        if ($value !== null) {
            return $value;
        }

        $value = DictionaryModel::field('value')
            ->where('type', '=', $type)
            ->where('key', '=', $key)
            ->order('sort', 'asc')
            ->value('value') ?? '';
        Cache::set($cacheKey, $value, $this->expire);

        return $value;
    }

    /**
     * 获取值串
     * @param $type
     * @param $keys
     * @param $glue
     * @return mixed|string
     */
    public function getValueString($type, $keys, $glue = '，')
    {
        $keyString = implode(',', $keys);
        $cacheKey = 'dictionary_' . $type . '_' . $keyString;
        $valueString = Cache::get($cacheKey);
        if ($valueString !== null) {
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