<?php

namespace app\service;

use Exception;

class CrudService
{
    /**
     * crud模型类
     * @var string
     */
    protected string $crudModelClass;

    /**
     * 构造函数
     * @param $modelClass
     * @throws Exception
     */
    public function __construct($modelClass)
    {
        if (!class_exists($modelClass)) {
            throw new Exception("模型类不存在：{$modelClass}");
        }
        $this->crudModelClass = $modelClass;
    }

    /**
     * 添加
     * @param $data
     * @return int
     */
    public function add($data)
    {
        $model = new $this->crudModelClass();
        $model->save($data);
        return $model->id;
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return boolean
     * @throws Exception
     */
    public function edit($id, $data)
    {
        if(isset($data['id'])){
            unset($data['id']);
        }
        if(empty($data)){
            throw new Exception('修改的数据不能为空');
        }
        $model = $this->crudModelClass::find($id);
        if (empty($model)) {
            throw new Exception('没有找到待修改的记录');
        }
        return $model->save($data);
    }

    /**
     * 通过字段修改
     * @param $field
     * @param $value
     * @param $data
     * @return boolean
     * @throws Exception
     */
    public function fieldEdit($field, $value, $data)
    {
        $models = $this->crudModelClass::where($field, $value)
            ->select();
        if($models->isEmpty()){
            throw new Exception('没有找到待修改的记录');
        }
        return $models->update($data);
    }

    /**
     * 修改或添加
     * @param $field
     * @param $value
     * @param $data
     * @return int
     * @throws Exception
     */
    public function upsert($field, $value, $data)
    {
        $model = $this->crudModelClass::where($field, $value)
            ->findOrEmpty();
        $model->save($data);
        return $model->id;
    }

    /**
     * 删除
     * @param $id
     * @return boolean
     * @throws Exception
     */
    public function delete($id)
    {
        $model = $this->crudModelClass::find($id);
        if (empty($model)) {
            throw new Exception('没有找到待删除的记录');
        }
        return $model->delete();
    }

    /**
     * 通过字段删除
     * @param $field
     * @param $value
     * @return boolean
     */
    public function fieldDelete($field, $value)
    {
        $models = $this->crudModelClass::where($field, $value)
            ->select();
        if($models->isEmpty()){
            throw new Exception('没有找到待删除的记录');
        }
        return $models->delete();
    }

    /**
     * 得到一行记录
     * @param $id
     * @param $field
     * @return array
     */
    public function fetch($id, $field = '*')
    {
        $model = $this->crudModelClass::field($field)
            ->findOrEmpty($id);
        return $model->toArray();
    }

    /**
     * 通过字段得到一行
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @return array
     */
    public function fieldFetch($whereField, $whereValue, $selectField = '*')
    {
        $model = $this->crudModelClass::field($selectField)
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
        return $this->fieldFetchValue('id', $id, $field);
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
        return $this->crudModelClass::field($selectField)
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
        return $this->crudModelClass::field($field)
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
     * @return array
     */
    public function fieldFetchColumn($whereField, $whereValue, $selectField, $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->crudModelClass::field($selectField)
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
     * @return array
     */
    public function fetchLimit($offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
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
     * @return array
     */
    public function fieldFetchLimit($whereField, $whereValue, $offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
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
     * @return array
     */
    public function fetchAll($selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
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
     * @return array
     */
    public function fieldFetchAll($whereField, $whereValue, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
            ->where($whereField, $whereValue)
            ->order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }
}