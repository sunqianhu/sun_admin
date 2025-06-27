<?php

namespace app\service;

use app\model\UserModel;
use app\model\UserRoleModel;
use Exception;
use Sunqianhu\Helper\thinkphp\Crud;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;

class UserService
{
    /**
     * 添加
     * @param $data
     * @return void
     * @throws Exception
     */
    public function add($data)
    {
        //账号
        $userModel = UserModel::where('account', $data['account'])->find();
        if (!empty($userModel)) {
            throw new Exception('此账号已经存在');
        }

        //手机号码
        $userModel = UserModel::where('phone', $data['phone'])->find();
        if (!empty($userModel)) {
            throw new Exception('手机号码已经存在');
        }

        $data['password'] = md5($data['password']);
        $userModel = new UserModel();
        $userModel->save($data);

        return $userModel->id;
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function edit($id, $data)
    {
        //账号
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }

        //手机号码
        if (isset($data['phone'])) {
            $phoneUserModel = UserModel::where('id', '<>', $id)
                ->where('phone', '=', $data['phone'])
                ->find();
            if (!empty($phoneUserModel)) {
                throw new Exception('此手机号码已经存在');
            }
        }

        $userModel->save($data);
    }

    /**
     * 修改密码
     * @param $id
     * @param $password
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function editPassword($id, $password)
    {
        $userCrud = new Crud(UserModel::class);
        $userCrud->update($id, [
            'password' => md5($password)
        ]);
    }

    /**
     * id转账号
     * @param $ids
     * @param string $glue
     * @return mixed|string
     */
    public function idsToAccountString($ids, $glue = ',')
    {
        if (empty($ids)) {
            return '';
        }

        $accounts = UserModel::whereIn('id', $ids)->column('account');
        if (empty($accounts)) {
            return '';
        }

        return implode($glue, $accounts);
    }

    /**
     * 得到姓名
     * @param $id
     * @return string
     */
    public function getName($id)
    {
        $key = 'user_name_' . $id;
        $name = Cache::get($key);
        if ($name !== null) {
            return $name;
        }

        $name = UserModel::where('id', $id)->value('name') ?? '';
        Cache::set($key, $name, 600);
        return $name;
    }

    /**
     * 得到角色id列表
     * @param $userId
     * @return array
     */
    public function getRoleIds($userId)
    {
        return UserRoleModel::where('user_id', $userId)
            ->group('role_id')
            ->column('role_id');
    }

    /**
     * 修改状态
     * @param $id
     * @param $status
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException|Exception
     */
    public function editStatus($id, $status)
    {
        $userCrud = new Crud(UserModel::class);
        return $userCrud->update($id, [
            'status' => $status
        ]);
    }
}