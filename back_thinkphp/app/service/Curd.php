<?php

namespace app\service;

use Exception;

class Curd
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
     * @return mixed
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
     * 查找
     * @param int $id
     * @return array
     */
    public function find(int $id)
    {
        $model = $this->curdModelClass::findOrEmpty($id);
        return $model->toArray();
    }

    /**
     * 查找值
     * @param $id
     * @param $field
     * @return mixed
     */
    public function findValue($id, $field = 'name')
    {
        $model = $this->curdModelClass::findOrEmpty($id);
        return $model->$field;
    }

    /**
     * 查找部分
     * @param $offset
     * @param $length
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function findLimit($offset, $length, $sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::limit($offset, $length)
            ->order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }

    /**
     * 查找全部
     * @param $sortField
     * @param $sortDirection
     * @return mixed
     */
    public function findAll($sortField = 'id', $sortDirection = 'asc')
    {
        $models = $this->curdModelClass::order($sortField, $sortDirection)
            ->select();
        return $models->toArray();
    }
}