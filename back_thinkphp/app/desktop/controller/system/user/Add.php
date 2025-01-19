<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\DepartmentService;
use app\service\UserService;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

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
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $user = new UserService();
            $user->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}