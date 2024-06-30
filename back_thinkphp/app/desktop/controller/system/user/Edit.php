<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;
use app\model\User as UserModel;
use app\service\Department as DepartmentService;
use app\service\User as UserServer;
use app\validate\User as UserValidate;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $userModel = UserModel::field('id,name,phone,department_id')
            ->with('roles')
            ->append(['role_ids'])
            ->find($id);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }
        $user = $userModel->toArray();

        //部门
        $departmentService = new DepartmentService();
        $treeDepartments = $departmentService->getTreeDepartments();

        //角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'user' => $user,
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name', 'phone', 'department_id', 'role_ids']);

        //验证
        try {
            validate(UserValidate::class)->scene('desktop_edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $userServer = new UserServer();
            $userServer->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}