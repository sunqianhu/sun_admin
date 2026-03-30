<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserRoleModel;
use app\helper\UserHelper;
use Sunqianhu\Helper\IdsValidator;
use app\validate\UserValidate;
use Exception;
use think\facade\Db;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status']);

        try {
            validate(UserValidate::class)->scene('add')->check($post);
            $idsValidator = new IdsValidator();
            $idsValidator->check('角色', $post['role_ids']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $userHelper = new UserHelper();
            $id = $userHelper->add($post);

            if (!empty($post['role_ids'])) {
                foreach ($post['role_ids'] as $roleId){
                    $userRoleModel = new UserRoleModel();
                    $userRoleModel->save([
                        'user_id' => $id,
                        'role_id' => $roleId
                    ]);
                }
            }

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}