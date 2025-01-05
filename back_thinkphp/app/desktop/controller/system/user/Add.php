<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;
use app\service\Department as DepartmentService;
use app\service\User as UserServer;
use app\validate\UserValidate as UserValidate;
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
        $departmentService = new DepartmentService();
        $treeDepartments = $departmentService->getTreeDepartments();

        //角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id']);

        //验证
        try {
            validate(UserValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $userServer = new UserServer();
            $userServer->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}