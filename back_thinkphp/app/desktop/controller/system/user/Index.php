<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\model\UserModel;
use app\service\Department;
use app\service\desktop\DesktopUser as DesktopUser;
use app\service\User;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        //部门
        $department = new Department();
        $treeDepartment = $department->getTreeDepartment();

        //角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'tree_departments' => $treeDepartment,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 获取用户
     */
    public function getUsers()
    {
        $get = $this->request->get(['department_id', 'role_id', 'account', 'name', 'phone', 'size' => 30, 'page' => 1]);

        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->field('u.id,u.account,u.name,u.phone,u.status,u.add_time,u.department_id')
            ->with('department');
        if (!empty($get['department_id'])) {
            $query = $query->where('u.department_id', '=', $get['department_id']);
        }
        if (!empty($get['role_id'])) {
            $query = $query->where('ur.role_id', '=', $get['role_id']);
        }
        if (isset($get['account']) && $get['account'] !== '') {
            $query = $query->where('u.account', 'LIKE', '%' . $get['account'] . '%');
        }
        if (isset($get['name']) && $get['name'] !== '') {
            $query = $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if (isset($get['phone']) && $get['phone'] !== '') {
            $query = $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query = $query->group('u.id')
            ->order('u.id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page']
        ]);
        $user = $paginate->toArray();

        return $this->success('获取成功', $user);
    }

    /**
     * 修改状态
     */
    function editStatus()
    {
        $post = $this->request->post(['id', 'status' => 0]);

        //验证
        try {
            validate(UserValidate::class)->scene('edit_status')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $user = new User();
            $user->editStatus($post['id'], $post['status']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }

    /**
     * 踢下线
     */
    function offLine()
    {
        $post = $this->request->post(['id']);

        //验证
        try {
            validate(UserValidate::class)->scene('offline')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $user = new DesktopUser();
            $user->offLine($post['id']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('操作成功');
    }
}