<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        //部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

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
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id']);

        //验证
        try {
            validate(UserValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //账号
        $userModel = UserModel::where('account', $post['account'])->find();
        if (!empty($userModel)) {
            return $this->error('账号已经存在');
        }

        //手机号码
        $userModel = UserModel::where('phone', $post['phone'])->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        $post['password'] = md5($post['password']);
        $post['add_time'] = time();
        $userModel = new UserModel();
        $userModel->save($post);

        if (!empty($post['role_ids'])) {
            foreach($post['role_ids'] as $roleId){
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id'=>$userModel->id,
                    'role_id'=>$roleId
                ]);
            }
        }

        return $this->success('添加成功');
    }
}