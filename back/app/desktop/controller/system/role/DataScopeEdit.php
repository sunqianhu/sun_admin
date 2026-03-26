<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\DataScopeModel;
use app\model\RoleDataScopePolicyModel;
use app\model\RoleModel;
use app\validate\role\RoleDataScopeValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\facade\Db;
use think\Response;

class DataScopeEdit extends Base
{
    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $get = $this->request->get(['role_id']);

        try {
            validate(RoleDataScopeValidate::class)->scene('edit_init')->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $roleDataScopePolicyModels = RoleDataScopePolicyModel::where('role_id', $get['role_id'])
            ->select();
        $roleDataScopePolicies = $roleDataScopePolicyModels->toArray();

        $dataScopeModels = DataScopeModel::with(['policies'])
            ->field('id,name,key')
            ->order('sort', 'asc')
            ->select();
        $dataScopes = $dataScopeModels->toArray();

        foreach($dataScopes as $key=>$dataScope){
            $dataScopes[$key]['policy_id'] = 0;
            foreach($roleDataScopePolicies as $roleDataScopePolicy){
                if($dataScope['id'] == $roleDataScopePolicy['data_scope_id']){
                    $dataScopes[$key]['policy_id'] = $roleDataScopePolicy['policy_id'];
                }
            }
        }

        $data = [
            'data_scopes' => $dataScopes
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['role_id', 'data_scopes'=> []]);

        try{
            validate(RoleDataScopeValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $roleModel = RoleModel::find($post['role_id']);
        if(empty($roleModel)){
            return $this->getErrorResponse('没有找到记录');
        }
        $dataScopes = $post['data_scopes'];

        Db::startTrans();
        try {
            RoleDataScopePolicyModel::where('role_id', $roleModel->id)->select()->delete();
            foreach($dataScopes as $dataScope){
                $data = [
                    'role_id' => $roleModel->id,
                    'data_scope_id' => $dataScope['id'],
                    'policy_id'=> $dataScope['policy_id']
                ];
                $roleDataScopePolicyModel = new RoleDataScopePolicyModel();
                $roleDataScopePolicyModel->save($data);
            }

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}