<?php

namespace app\helper\data_scope;

use app\model\data_scope\PolicyModel;
use Exception;

class PolicyHelper
{
    /**
     * 添加策略
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add($data)
    {
        $policyModel = new PolicyModel();
        $policyModel->save($data);
        return $policyModel->id;
    }

    /**
     * 修改策略
     * @param $id
     * @param array $data
     * @return void
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $policyModel = PolicyModel::find($id);
        if (empty($policyModel)) {
            throw new Exception('没有找到记录');
        }

        $policyModel->save($data);
    }

    /**
     * 删除策略
     * @param $id
     * @return void
     * @throws Exception
     */
    public function delete($id)
    {
        $policyModel = PolicyModel::find($id);
        if (empty($policyModel)) {
            throw new Exception('没有找到记录');
        }

        $policyModel->delete();
    }
}
