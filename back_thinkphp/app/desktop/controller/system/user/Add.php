<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\model\UserRoleModel;
use app\service\CrudService;
use app\validate\IdArrayValidate;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;
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
            IdArrayValidate::check($post['role_ids'], '角色');
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        Db::startTrans();
        try{
            $userCrudService = new CrudService(UserModel::class);
            $id = $userCrudService->add($post);

            if (!empty($post['role_ids'])) {
                $userRoleCrudService = new CrudService(UserRoleModel::class);
                foreach ($post['role_ids'] as $roleId){
                    $userRoleCrudService->add([
                        'user_id' => $id,
                        'role_id' => $roleId
                    ]);
                }
            }

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}