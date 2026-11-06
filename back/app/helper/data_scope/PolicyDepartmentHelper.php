<?php

namespace app\helper\data_scope;

use app\model\data_scope\PolicyDepartmentModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class PolicyDepartmentHelper
{
    /**
     * 添加策略与部门绑定
     * @param array $data
     * @return int
     */
    public function add($data)
    {
        $policyDepartmentModel = new PolicyDepartmentModel();
        $policyDepartmentModel->save($data);
        return $policyDepartmentModel->id;
    }

    /**
     * 通过策略删除部门绑定
     * @param $policyId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByPolicyId($policyId)
    {
        $policyDepartmentModels = PolicyDepartmentModel::where('policy_id', $policyId)->select();
        $policyDepartmentModels->delete();
    }
}
