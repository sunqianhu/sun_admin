<?php

namespace app\service;

use app\model\UserModel;
use app\model\UserRoleModel;
use Exception;
use Sunqianhu\Helper\Image;
use think\facade\Cache;

class User extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(UserModel::class);
    }

    /**
     * 添加
     * @param $data
     * @return void
     * @throws Exception
     */
    public function add($data)
    {
        //账号
        $user = UserModel::where('account', $data['account'])->find();
        if (!empty($user)) {
            throw new Exception('账号已经存在');
        }

        //手机号码
        $user = UserModel::where('phone', $data['phone'])->find();
        if (!empty($user)) {
            throw new Exception('手机号码已经存在');
        }

        $data['password'] = md5($data['password']);
        $user = new UserModel();
        $user->save($data);

        if (!empty($data['role_ids'])) {
            foreach ($data['role_ids'] as $roleId) {
                $userRole = new UserRoleModel();
                $userRole->save([
                    'user_id' => $user->id,
                    'role_id' => $roleId
                ]);
            }
        }
    }

    /**
     * 修改
     * @param $data
     * @return void
     * @throws Exception
     */
    public function edit($id, $data)
    {
        //手机号码
        $user = UserModel::where('id', '<>', $id)
            ->where('phone', '=', $data['phone'])
            ->find();
        if (!empty($user)) {
            throw new Exception('手机号码已经存在');
        }

        //账号
        $user = UserModel::find($data['id']);
        if (empty($user)) {
            throw new Exception('没有找到用户记录');
        }
        $user->save($data);

        UserRoleModel::where('user_id', $user->id)->delete();
        if (!empty($data['role_ids'])) {
            foreach ($data['role_ids'] as $roleId) {
                $userRole = new UserRoleModel();
                $userRole->save([
                    'user_id' => $user->id,
                    'role_id' => $roleId
                ]);
            }
        }
    }

    /**
     * 修改密码
     * @param $id
     * @param $password
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function editPassword($id, $password)
    {
        $user = UserModel::find($id);
        if (empty($user)) {
            throw new Exception('没有找到用户记录');
        }
        $user->password = md5($password);
        $user->save();
    }

    /**
     * id转账号
     * @param $use
     * @param $exclude
     * @return mixed|string
     */
    public function idsToAccountString($ids, $glue = ',')
    {
        if(empty($ids)){
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
     * @return mixed
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
     * 得到头像url
     * @param $path
     * @return string
     */
    public function getAvatarUrl($path)
    {
        if ($path === '') {
            $path = 'image/avatar.png';
            $site = new Site();
            return $site->getUrl($path);
        }

        $file = new File();
        return $file->getUrl($path);
    }

    /**
     * 得到角色id列表
     * @param $userId
     * @return mixed
     */
    public function getRoleIds($userId)
    {
        $roleIds = UserRoleModel::where('user_id', $userId)
            ->group('role_id')
            ->column('role_id');
        return array_unique($roleIds);
    }

    /**
     * 修改头像
     * @param $id
     * @param $base64ImageContent
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editAvatar($id, $base64ImageContent)
    {
        $file = new File();
        $path = $file->saveBase64ImageContentToFile('avatar', $base64ImageContent);

        $fullPath = $file->getFullPath($path);
        $image = new Image();
        $image->createThumbnail($fullPath, $fullPath, 100);

        $this->edit($id, [
            'avatar' => $path
        ]);
        return $path;
    }

    /**
     * 修改状态
     * @param $id
     * @param $status
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editStatus($id, $status)
    {
        $this->edit($id, [
            'status' => $status
        ]);
    }

    /**
     * 通过部门id列表得到id列表
     * @param $departmentIds
     * @return array
     */
    public function getDepartmentUserIds($departmentIds)
    {
        return UserModel::whereIn('department_id', $departmentIds)
            ->where('status', 1)
            ->column('id');
    }
}