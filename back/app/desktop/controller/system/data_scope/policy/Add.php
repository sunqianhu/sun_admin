<?php

namespace app\desktop\controller\system\data_scope\policy;

use app\desktop\controller\Base;
use app\helper\data_scope\PolicyDepartmentHelper;
use app\helper\data_scope\PolicyHelper;
use app\validate\data_scope\PolicyValidate;
use Exception;
use Sunqianhu\Helper\IdsValidator;
use think\exception\ValidateException;
use think\facade\Db;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['data_scope_id'=>0, 'name', 'type'=>0, 'department_ids'=>[], 'sort']);

        try {
            validate(PolicyValidate::class)->scene('add')->check($post);
            if($post['type'] == 98){
                $idsValidator = new IdsValidator();
                $idsValidator->check('指定部门', $post['department_ids']);
            }
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $data = $post;
            unset($data['department_ids']);
            $policyHelper = new PolicyHelper();
            $id = $policyHelper->add($data);

            $policyDepartmentHelper = new PolicyDepartmentHelper();
            foreach($post['department_ids'] as $departmentId){
                $data = [
                    'policy_id'=>$id,
                    'department_id'=>$departmentId
                ];
                $policyDepartmentHelper->add($data);
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
