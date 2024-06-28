<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;
use app\service\Department as DepartmentService;
use app\service\desktop\session\Jwt;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        //部门
        $departmentService = new DepartmentService();
        $treeDepartments = $departmentService->getTreeDepartments();

        //角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'tree_departments' => $treeDepartments,
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
            ->field('u.id,u.account,u.name,u.phone,u.status_id,u.add_time,u.department_id')
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
        $post = $this->request->post(['id', 'status_id' => 0]);

        //验证
        try {
            validate(UserValidate::class)->scene('edit_status')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($post['id']);
        if(empty($userModel)){
            return $this->error('没有找到用户记录');
        }
        $userModel->save($post);

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

        $jwt = new Jwt();
        $jwt->deleteToken($post['id']);

        return $this->success('操作成功');
    }
}