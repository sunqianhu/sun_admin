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
    private int $expire = 60 * 60 * 7;

    /**
     * 添加
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add($data)
    {
        $dictionaryModel = new DictionaryModel();
        $dictionaryModel->save($data);
        $this->clearCache();

        return $dictionaryModel->id;
    }

    /**
     * 修改
     * @param $id
     * @param array $data
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $dictionaryModel = DictionaryModel::where('id', $id)->find();
        if (empty($dictionaryModel)) {
            throw new Exception('没有找到字典记录');
        }

        $dictionaryModel->save($data);
        $this->clearCache();
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function delete($id)
    {
        $dictionaryModel = DictionaryModel::where('id', $id)->find();
        if (empty($dictionaryModel)) {
            throw new Exception('没有找到字典记录');
        }

        $dictionaryModel->delete();
        $this->clearCache();
    }

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
        $cacheKey = 'dictionary:list:' . $type;
        $list = Cache::get($cacheKey);
        if ($list !== null) {
            return $list;
        }

        $dictionaryModels = DictionaryModel::where('type', $type)
            ->field('key,value')
            ->order('sort', 'asc')
            ->select();
        $list = $dictionaryModels->toArray();
        Cache::tag('dictionary')->set($cacheKey, $list, $this->expire);

        return $list;
    }

    /**
     * 获取值
     * @param $type
     * @param $key
     * @return mixed
     * @throws Exception
     */
    public function getValue($type, $key)
    {
        $cacheKey = 'dictionary:value:' . $type . ':' . $key;
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
        Cache::tag('dictionary')->set($cacheKey, $value, $this->expire);

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
        $keysString = implode(',', $keys);
        $cacheKey = 'dictionary:values:' . $type . ':' . md5(serialize([$keys, $glue]));
        $valueString = Cache::get($cacheKey);
        if ($valueString !== null) {
            return $valueString;
        }

        $values = DictionaryModel::where('type', $type)
            ->where('key', 'in', $keysString)
            ->field('value')
            ->order('sort', 'asc')
            ->column('value');
        $valuesString = implode($glue, $values);
        Cache::tag('dictionary')->set($cacheKey, $valuesString, $this->expire);

        return $valuesString;
    }

    /**
     * @throws ModelNotFoundException
     * @throws DataNotFoundException
     * @throws DbException
     */
    public function getKey($type, $value)
    {
        $cacheKey = 'dictionary:key:' . $type . ':' . md5($value);
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
        Cache::tag('dictionary')->set($cacheKey, $key, $this->expire);

        return $key;
    }

    /**
     * 清除缓存
     * @return bool
     */
    public function clearCache(): bool
    {
        return Cache::tag('dictionary')->clear();
    }
}
