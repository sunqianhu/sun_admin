<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化修改
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $userModel = UserModel::field('id,name,phone,department_id')
            ->with('roles')
            ->find($id);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }
        $user = $userModel->toArray();
        $user['role_ids'] = [];
        if (!empty($user['roles'])) {
            $user['role_ids'] = array_column($user['roles'], 'id');
        }

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
            'user' => $user,
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name', 'phone', 'department_id', 'role_ids']);

        //验证
        try {
            validate(UserValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //手机号码
        $userModel = UserModel::where('id', '<>', $post['id'])
            ->where('phone', '=', $post['phone'])
            ->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        //账号
        $userModel = UserModel::find($post['id']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }

        $post['edit_time'] = time();
        $userModel->save($post);

        $oldRoleIds = array_column($userModel->roles->toArray(), 'id');
        $deleteRoleIds = array_unique(array_values(array_diff($oldRoleIds, $post['role_ids'])));
        $addRoleIds = array_unique(array_values(array_diff($post['role_ids'], $oldRoleIds)));
        if(!empty($deleteRoleIds)){
            foreach($deleteRoleIds as $deleteRoleId){
                $userRoleModel = UserRoleModel::where('user_id', $userModel->id)
                    ->where('role_id', $deleteRoleId)
                    ->findOrEmpty();
                $userRoleModel->delete();
            }
        }
        if(!empty($addRoleIds)) {
            foreach($addRoleIds as $addRoleId){
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id'=>$userModel->id,
                    'role_id'=>$addRoleId
                ]);
            }
        }

        return $this->success('修改成功');
    }
}