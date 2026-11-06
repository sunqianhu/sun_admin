<?php

namespace app\helper\role;

use app\model\data_scope\PolicyModel;
use app\model\RolePolicyModel;
use Exception;
use Sunqianhu\Helper\IdsValidator;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class RolePolicyHelper
{
    /**
     * 添加角色与策略绑定
     * @param array $data
     * @return int
     */
    public function add($data)
    {
        $rolePolicyModel = new RolePolicyModel();
        $rolePolicyModel->save($data);
        return $rolePolicyModel->id;
    }

    /**
     * 设置角色与策略的关系，空数组表示清空授权
     * @param $roleId
     * @param array $policyIds
     * @return void
     * @throws Exception
     */
    public function setRelation($roleId, $policyIds)
    {
        Db::startTrans();
        try {
            $this->deleteByRoleId($roleId);
            foreach ($policyIds as $policyId) {
                $policyModel = PolicyModel::find($policyId);
                if (empty($policyModel)) {
                    throw new Exception('没有找到策略记录');
                }
                $this->add([
                    'role_id' => $roleId,
                    'policy_id' => $policyModel->id
                ]);
            }

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 通过角色删除策略绑定
     * @param $roleId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByRoleId($roleId)
    {
        $rolePolicyModels = RolePolicyModel::where('role_id', $roleId)->select();
        $rolePolicyModels->delete();
    }

    /**
     * 通过策略删除角色绑定
     * @param $policyId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function deleteByPolicyId($policyId)
    {
        $rolePolicyModels = RolePolicyModel::where('policy_id', $policyId)->select();
        $rolePolicyModels->delete();
    }
}
