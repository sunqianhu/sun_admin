<?php

namespace app\service;

use app\model\desktop\Permission as PermissionModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use app\service\desktop\Permission as PermissionService;
use app\service\User as UserService;
use Sunqianhu\Helper\ArrayHandler;
use think\facade\Cache;
use app\service\File as FileService;
use app\service\App as AppService;

class User
{
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
     * 字符串转id
     * @param $idString
     * @return void
     */
    public function stringToIds($idString, $delimiter = ',')
    {
        if ($idString === 'all') {
            return UserModel::where('status_id', 1)
                ->column('id');
        }

        return explode($delimiter, $idString);
    }

    /**
     * 得到姓名
     * @param $id
     * @return mixed
     */
    public function getName($id)
    {
        $key = 'user_name_'.$id;
        $name = Cache::get($key);
        if($name !== null){
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
        if($path === ''){
            $path = 'image/avatar.png';
            $appService = new AppService();
            return $appService->getUrl($path);
        }

        $fileService = new FileService();
        return $fileService->getUrl($path);
    }

    /**
     * 得到角色id集合
     * @param $userId
     * @return mixed
     */
    public function getRoleIds($userId){
        $roleIds = UserRoleModel::where('user_id', $userId)
            ->group('role_id')
            ->column('role_id');
        return $roleIds;
    }
}