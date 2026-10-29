<?php

namespace app\desktop\controller\system\data_scope\policy;

use app\desktop\controller\Base;
use app\model\data_scope\PolicyDepartmentModel;
use app\model\data_scope\PolicyModel;
use app\validate\data_scope\PolicyValidate;
use app\validate\IdValidate;
use Exception;
use Sunqianhu\Helper\IdsValidator;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\facade\Db;
use think\Response;

class Edit extends Base
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
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        $policyModel = PolicyModel::with(['departments'=>function ($query) {
            $query->field('id,name');
        }])
            ->append(['department_ids'])
            ->find($id);
        if (empty($policyModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $data_scope = $policyModel->toArray();

        return $this->getSuccessResponse('获取成功', $data_scope);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'data_scope_id'=>0, 'name', 'type'=>0, 'department_ids'=>[], 'sort']);

        try {
            validate(PolicyValidate::class)->scene('edit')->check($post);
            if($post['type'] == 98){
                $idsValidator = new IdsValidator();
                $idsValidator->check('指定部门', $post['department_ids']);
            }
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        $policyModel = PolicyModel::find($post['id']);
        if(empty($policyModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        Db::startTrans();
        try{
            $policyModel->save($post);
            $id = $policyModel->id;

            PolicyDepartmentModel::where('policy_id', $id)->select()->delete();
            foreach($post['department_ids'] as $departmentId){
                $data = [
                    'policy_id'=>$id,
                    'department_id'=>$departmentId
                ];
                $policyDepartmentModel = new PolicyDepartmentModel();
                $policyDepartmentModel->save($data);
            }
            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}