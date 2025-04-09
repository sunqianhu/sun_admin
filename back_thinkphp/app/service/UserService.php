<?php

namespace app\service;

use app\model\UserModel;
use app\model\UserRoleModel;
use Exception;
use Sunqianhu\Helper\File;
use Sunqianhu\Helper\Image;
use think\facade\Cache;
use think\facade\Db;

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
     * @param $data
     * @return void
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
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function editPassword($id, $password)
    {
        $userCrudService = new CrudService(UserModel::class);
        $userCrudService->edit($id, [
            'password' => md5($password)
        ]);
    }

    /**
     * id转账号
     * @param $use
     * @param $exclude
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
            $siteService = new SiteService();
            return $siteService->getUrl($path);
        }

        $file = new File();
        return $file->getUrl($path);
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
     * 通过base64图片内容修改头像
     * @param $id
     * @param $base64ImageContent
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editAvatarByBase64ImageContent($id, $base64ImageContent)
    {
        $image = new Image();
        $path = $image->saveBase64ContentToFile('avatar', $base64ImageContent);

        $file = new File();
        $fullPath = $file->getFullPath($path);
        $image->generateThumbnail($fullPath, $fullPath, 200);

        $this->editAvatar($id, $path);
        return $path;
    }

    /**
     * 修改头像
     * @param $id
     * @param $path
     * @return void
     * @throws Exception
     */
    public function editAvatar($id, $path)
    {
        $userCrudService = new CrudService(UserModel::class);
        $userCrudService->edit($id, [
            'avatar' => $path
        ]);
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
        $userCrudService = new CrudService(UserModel::class);
        $userCrudService->edit($id, [
            'status' => $status
        ]);
    }
}