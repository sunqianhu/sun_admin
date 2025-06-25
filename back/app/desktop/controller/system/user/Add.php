<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\model\UserRoleModel;
use Sunqianhu\Helper\thinkphp\Crud;
use Sunqianhu\Helper\IdsValidate;
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

        //验证
        try {
            validate(UserValidate::class)->scene('add')->check($post);
            IdsValidate::check($post['role_ids'], '角色');
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        Db::startTrans();
        try{
            $userCrud = new Crud(UserModel::class);
            $id = $userCrud->insert($post);

            if (!empty($post['role_ids'])) {
                $userRoleCrud = new Crud(UserRoleModel::class);
                foreach ($post['role_ids'] as $roleId){
                    $userRoleCrud->insert([
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

        return $this->getSuccessResonse('添加成功');
    }
}