<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\Department;
use app\service\User;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        ///部门
        $department = new Department();
        $treeDepartment = $department->getTreeDepartment();

        //角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'departments' => $treeDepartment,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

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
            $user = new User();
            $user->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}