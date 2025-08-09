<?php

namespace app\service;

use app\model\UserModel;
use app\model\UserRoleModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserService
{
    /**
     * 得到id
     * @param $name
     * @return string
     * @throws Exception
     */
    public function getId($name)
    {
        $userModel = UserModel::field('id')
            ->where('name', $name)
            ->find();
        if(empty($userModel)){
            throw new Exception('没有找到用户记录');
        }
        return $userModel->id;
    }

    /**
     * 得到姓名
     * @param $id
     * @return string
     * @throws Exception
     */
    public function getName($id)
    {
        $userModel = UserModel::field('name')->find($id);
        if(empty($userModel)){
            throw new Exception('没有找到用户记录');
        }
        return $userModel->name;
    }

    /**
     * 添加
     * @param $data
     * @return int
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
        if(isset($data['phone'])){
            $userModel = UserModel::where('phone', $data['phone'])->find();
            if (!empty($userModel)) {
                throw new Exception('手机号码已经存在');
            }
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
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->save([
            'password' => md5($password)
        ]);
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
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->status = $status;
        return $userModel->save();
    }

    /**
     * id转账号
     * @param $ids
     * @param string $glue
     * @return mixed|string
     */
    public function idsToAccountsString($ids, $glue = ',')
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
}