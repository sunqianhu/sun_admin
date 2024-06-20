<?php

namespace app\service;

use app\model\desktop\Module as ModuleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use think\facade\Cache;
use app\service\File as FileService;

class User
{
    /**
     * 用户id转用户账号
     * @param $use
     * @param $exclude
     * @return mixed|string
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
        $key = 'user_'.$id;
        $name = Cache::get($key);
        if($name !== null){
            return $name;
        }

        $name = UserModel::where('id', $id)->value('name');
        Cache::set($key, $name, 600);
        return $name;
    }

    /**
     * 通过桌面端模块key得到用户ids
     * @param $menuKey
     * @param $departmentIds
     * @return array
     */
    public function getIdsByDesktopModuleKey($moduleKey, $departmentIds = []){
        $userIds = [];

        //角色id
        $roleIds = ModuleModel::alias('m')
            ->leftJoin('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->where('m.key', $moduleKey)
            ->group('rdm.role_id')
            ->column('rdm.role_id');
        if(empty($roleIds)){
            return $userIds;
        }

        //用户id
        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->where('ur.role_id', 'in', $roleIds)
            ->where('u.status_id', 1)
            ->group('u.id');
        if(!empty($departmentIds)){
            $query = $query->where('u.department_id', 'in', $departmentIds);
        }
        $userIds = $query->column('u.id');

        return $userIds;
    }

    /**
     * 得到头像url
     * @param $path
     * @return string
     */
    public function getAvatarUrl($path)
    {
        if($path === ''){
            $path = 'avatar.png';
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