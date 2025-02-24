<?php

namespace app\service;

use Exception;

class CurdService
{
    /**
     * curd模型类
     * @var string
     */
    protected string $curdModelClass;

    /**
     * 构造函数
     * @param $model
     */
    public function __construct($modelClass)
    {
        if (!class_exists($modelClass)) {
            throw new Exception('curd模型类不存在');
        }
        $this->curdModelClass = $modelClass;
    }

    /**
     * 添加
     * @param $data
     * @return int
     */
    public function add($data)
    {
        $model = new $this->curdModelClass();
        $model->save($data);
        return $model->id;
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws Exception
     */
    public function edit($id, $data)
    {
        if(isset($data['id'])){
            unset($data['id']);
        }

        $model = $this->curdModelClass::find($id);
        if (empty($model)) {
            throw new Exception('没有找到记录');
        }
        $model->save($data);
    }

    /**
     * 通过字段修改
     * @param $field
     * @param $value
     * @param $data
     * @return void
     * @throws Exception
     */
    public function fieldEdit($field, $value, $data)
    {
        if(isset($data[$field])){
            unset($data[$field]);
        }

        $models = $this->curdModelClass::where($field, $value)
            ->select();
        if($models->isEmpty()){
            return;
        }
        $models->update($data);
    }

    /**
     * 修改或添加
     * @param $field
     * @param $value
     * @param $data
     * @return void
     * @throws Exception
     */
    public function upsert($field, $value, $data)
    {
        if(isset($data[$field])){
            unset($data[$field]);
        }

        $model = $this->curdModelClass::where($field, $value)
            ->findOrEmpty();
        $model->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete($id)
    {
        $model = $this->curdModelClass::find($id);
        if (empty($model)) {
            throw new Exception('没有找到记录');
        }
        $model->delete();
    }

    /**
     * 通过字段删除
     * @param $field
     * @param $value
     * @return void
     */
    public function fieldDelete($field, $value)
    {
        $models = $this->curdModelClass::where($field, $value)
            ->select();
        if($models->isEmpty()){
            return;
        }
        $models->delete();
    }

    /**
     * 得到一行记录
     * @param $id
     * @param $field
     * @return mixed
     */
    public function fetch($id, $field = '*')
    {
        $model = $this->curdModelClass::field($field)
            ->findOrEmpty($id);
        return $model->toArray();
    }

    /**
     * 通过字段得到一行
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @return mixed
     */
    public function fieldFetch($whereField, $whereValue, $selectField = '*')
    {
        $model = $this->curdModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->findOrEmpty();
        return $model->toArray();
    }

    /**
     * 得到一行记录的一个字段的值
     * @param $id
     * @param $field
     * @return mixed
     */
    public function fetchValue($id, $field)
    {
        $model = $this->curdModelClass::field($field)
            ->findOrEmpty($id);
        return $model->$field;
    }

    /**
     * 通过字段得到一行记录的一个字段的值
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @return mixed
     */
    public function fieldFetchValue($whereField, $whereValue, $selectField)
    {
        return $this->curdModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->value($selectField) ?? '';
    }

    /**
     * 得到一列
     * @param $field
     * @param $sortField
     * @param $sortDirection
     * @return array
     */
    public function fetchColumn($field, $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->curdModelClass::field($field)
            ->order($sortField, $sortDirection)
            ->column($field);
    }

    /**
     * 通过字段得到一列
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function fieldFetchColumn($whereField, $whereValue, $selectField, $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->curdModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->order($sortField, $sortDirection)
            ->column($selectField);
    }

    /**
     * 得到部分
     * @param $offset
     * @param $length
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function fetchLimit($offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::field($selectField)
            ->order($sortField, $sortDirection)
            ->limit($offset, $length)
            ->select();
        return $models->toArray();
    }

    /**
     * 通过字段得到部分
     * @param $whereField
     * @param $whereValue
     * @param $offset
     * @param $length
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function fieldFetchLimit($whereField, $whereValue, $offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->order($sortField, $sortDirection)
            ->limit($offset, $length)
            ->select();
        return $models->toArray();
    }

    /**
     * 得到全部
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function fetchAll($selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::field($selectField)
            ->order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }

    /**
     * 通过字段得到全部
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function fieldFetchAll($whereField, $whereValue, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }
}