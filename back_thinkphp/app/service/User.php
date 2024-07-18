<?php

namespace app\service;

use app\model\desktop\Token as TokenModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use Exception;
use Sunqianhu\Helper\Image as ImageHelper;
use think\facade\Cache;
use app\service\File as FileService;
use app\service\Site as SiteService;

class User
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
            throw new Exception('账号已经存在');
        }

        //手机号码
        $userModel = UserModel::where('phone', $data['phone'])->find();
        if (!empty($userModel)) {
            throw new Exception('手机号码已经存在');
        }

        $data['password'] = md5($data['password']);
        $data['add_time'] = time();
        $userModel = new UserModel();
        $userModel->save($data);

        if (!empty($data['role_ids'])) {
            foreach ($data['role_ids'] as $roleId) {
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id' => $userModel->id,
                    'role_id' => $roleId
                ]);
            }
        }
    }

    /**
     * 修改
     * @param $data
     * @return void
     */
    public function edit($id, $data)
    {
        //手机号码
        $userModel = UserModel::where('id', '<>', $id)
            ->where('phone', '=', $data['phone'])
            ->find();
        if (!empty($userModel)) {
            throw new Exception('手机号码已经存在');
        }

        //账号
        $userModel = UserModel::find($data['id']);
        if (empty($userModel)) {
            throw new Exception('没有找到记录');
        }

        $data['edit_time'] = time();
        $userModel->save($data);

        UserRoleModel::where('user_id', $userModel->id)->delete();
        if (!empty($data['role_ids'])) {
            foreach ($data['role_ids'] as $roleId) {
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id' => $userModel->id,
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
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到记录');
        }
        $userModel->password = md5($password);
        $userModel->save();
    }

    /**
     * id转账号
     * @param $idString
     * @param $fromDelimiter
     * @param $toGlue
     * @return string
     */
    public function idToAccount($idString, $fromDelimiter = ',', $toGlue = ',')
    {
        $ids = explode($fromDelimiter, $idString);
        if (empty($ids)) {
            return '';
        }

        $accounts = UserModel::where('id', 'in', $ids)->column('account');
        if (empty($accounts)) {
            return '';
        }
        return implode($toGlue, $accounts);
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

        $name = UserModel::where('id', $id)->value('name');
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

        $fileService = new FileService();
        return $fileService->getUrl($path);
    }

    /**
     * 得到角色id集合
     * @param $userId
     * @return mixed
     */
    public function getRoleIds($userId)
    {
        $roleIds = UserRoleModel::where('user_id', $userId)
            ->group('role_id')
            ->column('role_id');
        return $roleIds;
    }

    /**
     * 修改头像
     * @param $id
     * @param $base64Content
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editAvatar($id, $base64Content)
    {
        $fileService = new FileService();
        $path = $fileService->saveBase64ContentToFile('avatar', $base64Content);

        $fullPath = $fileService->getFullPath($path);
        $imageHelper = new ImageHelper();
        $imageHelper->thumbnail($fullPath, $fullPath, 100, 100);

        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $userModel->avatar = $path;
        $userModel->save();

        return $path;
    }

    /**
     * 修改状态
     * @param $id
     * @param $statusId
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editStatus($id, $statusId)
    {
        $userModel = UserModel::find($id);
        if (empty($userModel)) {
            throw new Exception('没有找到记录');
        }
        $userModel->status_id = $statusId;
        $userModel->save();
    }

    /**
     * 通过部门id集合得到id集合
     * @param $departmentIds
     * @return array
     */
    public function getIdsByDepartmentIds($departmentIds)
    {
        return UserModel::where('department_id', 'in', $departmentIds)->column('id');
    }
}