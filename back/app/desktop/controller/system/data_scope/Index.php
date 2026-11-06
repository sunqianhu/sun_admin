<?php

namespace app\desktop\controller\system\data_scope;

use app\desktop\controller\Base;
use app\helper\DataScopeHelper;
use app\helper\data_scope\PolicyDepartmentHelper;
use app\helper\data_scope\PolicyHelper;
use app\helper\role\RolePolicyHelper;
use app\helper\user\UserDataScopeHelper;
use app\model\DataScopeModel;
use app\validate\PaginationValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Db;
use think\Response;

class Index extends Base
{
    /**
     * 得到分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['name' => '', 'key' => '', 'size' => '30', 'page' => '1']);

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = DataScopeModel::field('id,name,key,sort');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['key'] !== '') {
            $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        $query->order('sort', 'asc');
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();
        return $this->getSuccessResponse('获取成功', $paginate);
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
            $dataScopeHelper = new DataScopeHelper();
            $dataScopeHelper->delete($id);

            $policyIds = $dataScopeHelper->getPolicyIds($id);
            $policyHelper = new PolicyHelper();
            $rolePolicyHelper = new RolePolicyHelper();
            $policyDepartmentHelper = new PolicyDepartmentHelper();
            foreach ($policyIds as $policyId) {
                $policyHelper->delete($policyId);
                $rolePolicyHelper->deleteByPolicyId($policyId);
                $policyDepartmentHelper->deleteByPolicyId($policyId);
            }

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
