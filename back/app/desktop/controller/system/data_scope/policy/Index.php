<?php

namespace app\desktop\controller\system\data_scope\policy;

use app\desktop\controller\Base;
use app\helper\data_scope\PolicyDepartmentHelper;
use app\helper\data_scope\PolicyHelper;
use app\helper\role\RolePolicyHelper;
use app\helper\user\UserDataScopeHelper;
use app\model\data_scope\PolicyModel;
use Exception;
use think\facade\Db;
use think\Response;

class Index extends Base
{
    /**
     * 得到策略列表
     */
    public function getPolicies()
    {
        $get = $this->request->get(['data_scope_id'=>0]);
        if(!is_numeric($get['data_scope_id']) ||  $get['data_scope_id'] <= 0){
            return $this->getErrorResponse('数据权限ID错误');
        }

        $policyModels = PolicyModel::field('id,name,sort')
            ->where('data_scope_id', $get['data_scope_id'])
            ->order('sort', 'asc')
            ->select();
        $policies = $policyModels->toArray();
        return $this->getSuccessResponse('获取成功', $policies);
    }

    /**
     * 删除
     * @return Response
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        Db::startTrans();
        try{
            $policyHelper = new PolicyHelper();
            $policyHelper->delete($id);

            $rolePolicyHelper = new RolePolicyHelper();
            $rolePolicyHelper->deleteByPolicyId($id);

            $policyDepartmentHelper = new PolicyDepartmentHelper();
            $policyDepartmentHelper->deleteByPolicyId($id);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        $userDataScopeHelper = new UserDataScopeHelper();
        $userDataScopeHelper->clearCache();

        return $this->getSuccessResponse('删除成功');
    }
}
