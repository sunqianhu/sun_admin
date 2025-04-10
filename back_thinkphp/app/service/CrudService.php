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
     * 添加并设置添加时间
     * @param $data
     * @return int
     */
    public function addWithAddTimeNow($data)
    {
        $data['add_time'] = time();
        return $this->add($data);
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
            return true;
        }
        return $model->save($data);
    }

    /**
     * 通过字段修改
     * @param $field
     * @param $value
     * @param $data
     * @return boolean
     */
    public function editByField($field, $value, $data)
    {
        return $this->editByWhere([$field=>$value], $data);
    }

    /**
     * 通过条件修改
     * @param $where
     * @param $data
     * @return true
     */
    public function editByWhere($where, $data)
    {
        $models = $this->crudModelClass::where($where)
            ->select();
        if($models->isEmpty()){
            return true;
        }
        return $models->update($data);
    }

    /**
     * 修改或添加
     * @param $field
     * @param $value
     * @param $data
     * @return int
     */
    public function upsert($field, $value, $data)
    {
        return $this->upsertByWhere([$field=>$value], $data);
    }

    /**
     * 通过条件修改或添加
     * @param $where
     * @param $data
     * @return mixed
     */
    public function upsertByWhere($where, $data)
    {
        $model = $this->crudModelClass::where($where)
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
            return true;
        }
        return $model->delete();
    }

    /**
     * 通过字段删除
     * @param $field
     * @param $value
     * @return boolean
     */
    public function deleteByField($field, $value)
    {
        return $this->deleteByWhere([$field=>$value]);
    }

    /**
     * 通过条件删除
     * @param $where
     * @return true
     */
    public function deleteByWhere($where)
    {
        $models = $this->crudModelClass::where($where)
            ->select();
        if($models->isEmpty()){
            return true;
        }
        return $models->delete();
    }

    /**
     * 得到一行记录
     * @param $id
     * @param $field
     * @return array
     */
    public function find($id, $field = '*')
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
    public function findByField($whereField, $whereValue, $selectField = '*')
    {
        return $this->findByWhere([$whereField=>$whereValue], $selectField);
    }

    /**
     * 通过条件得到一行
     * @param $where
     * @param $selectField
     * @return mixed
     */
    public function findByWhere($where, $selectField = '*')
    {
        $model = $this->crudModelClass::field($selectField)
            ->where($where)
            ->findOrEmpty();
        return $model->toArray();
    }

    /**
     * 通过主键得到一行记录的一个字段的值
     * @param $id
     * @param $field
     * @return mixed
     */
    public function getValue($id, $field)
    {
        return $this->getValueByWhere(['id'=>$id], $field);
    }

    /**
     * 通过字段得到一行记录的一个字段的值
     * @param $whereField
     * @param $whereValue
     * @param $selectField
     * @return mixed
     */
    public function getValueByField($whereField, $whereValue, $selectField)
    {
        return $this->getValueByWhere([$whereField=>$whereValue], $selectField);
    }

    /**
     * 通过条件得到一行记录的一个字段的值
     * @param $where
     * @param $selectField
     * @return mixed
     */
    public function getValueByWhere($where, $selectField)
    {
        return $this->crudModelClass::field($selectField)
            ->where($where)
            ->value($selectField);
    }

    /**
     * 得到一列
     * @param $field
     * @param $sortField
     * @param $sortDirection
     * @return array
     */
    public function getColumn($field, $sortField = 'id', $sortDirection = 'asc')
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
    public function getColumnByField($whereField, $whereValue, $selectField, $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->getColumnByWhere([$whereField=>$whereValue], $selectField, $sortField, $sortDirection);
    }

    /**
     * 通过条件得到一列
     * @param $where
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function getColumnByWhere($where, $selectField, $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->crudModelClass::field($selectField)
            ->where($where)
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
    public function getLimit($offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
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
    public function getLimitByField($whereField, $whereValue, $offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->getLimitByWhere([$whereField=>$whereValue], $offset, $length, $selectField, $sortField, $sortDirection);
    }

    /**
     * 通过条件得到部分
     * @param $where
     * @param $offset
     * @param $length
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return array
     */
    public function getLimitByWhere($where, $offset, $length, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
            ->where($where)
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
    public function getAll($selectField='*', $sortField = 'id', $sortDirection = 'asc')
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
    public function getAllByField($whereField, $whereValue, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        return $this->getAllByWhere([$whereField=>$whereValue], $selectField, $sortField, $sortDirection);
    }

    /**
     * 通过条件得到全部
     * @param $where
     * @param $selectField
     * @param $sortField
     * @param $sortDirection
     * @return array
     */
    public function getAllByWhere($where, $selectField='*', $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->crudModelClass::field($selectField)
            ->where($where)
            ->order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }
}