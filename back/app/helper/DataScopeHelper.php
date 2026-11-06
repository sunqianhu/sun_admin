<?php

namespace app\helper;

use app\model\data_scope\PolicyModel;
use app\model\DataScopeModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class DataScopeHelper
{
    /**
     * 添加数据权限
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add($data)
    {
        $dataScopeModel = new DataScopeModel();
        $dataScopeModel->save($data);
        return $dataScopeModel->id;
    }

    /**
     * 得到所有数据权限及策略
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getDataScopes()
    {
        return DataScopeModel::with(['policies'])
            ->field('id,name,key')
            ->order('sort', 'asc')
            ->select()
            ->toArray();
    }

    /**
     * 得到数据权限的策略ID列表
     * @param $id
     * @return array
     */
    public function getPolicyIds($id)
    {
        return PolicyModel::where('data_scope_id', $id)->column('id');
    }

    /**
     * 修改数据权限
     * @param $id
     * @param array $data
     * @return void
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $dataScopeModel = DataScopeModel::find($id);
        if (empty($dataScopeModel)) {
            throw new Exception('没有找到记录');
        }

        $dataScopeModel->save($data);
    }

    /**
     * 删除数据权限
     * @param $id
     * @return void
     * @throws Exception
     */
    public function delete($id)
    {
        $dataScopeModel = DataScopeModel::find($id);
        if (empty($dataScopeModel)) {
            throw new Exception('没有找到记录');
        }

        $dataScopeModel->delete();
    }
}
