<?php

namespace app\desktop\controller\system\data_scope\policy;

use app\desktop\controller\Base;
use app\model\data_scope\PolicyModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
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
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $policyModel = PolicyModel::find($id);
        if(empty($policyModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $policyModel->delete();
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}