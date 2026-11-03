<?php

namespace app\desktop\controller\system\data_scope;

use app\desktop\controller\Base;
use app\model\data_scope\PolicyDepartmentModel;
use app\model\data_scope\PolicyModel;
use app\model\DataScopeModel;
use app\model\RoleDataScopePolicyModel;
use app\validate\PaginationValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
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
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $dataScopeModel = DataScopeModel::find($id);
        if(empty($dataScopeModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        Db::startTrans();
        try{
            $dataScopeModel->delete();

            RoleDataScopePolicyModel::where('data_scope_id', $id)->select()->delete();
            $policyQuery = PolicyModel::where('data_scope_id', $id);
            PolicyDepartmentModel::whereIn('policy_id', $policyQuery->column('id'))->select()->delete();
            $policyQuery->select()->delete();

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}
