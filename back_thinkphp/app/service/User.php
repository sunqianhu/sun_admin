<?php

namespace app\service;

use app\model\desktop\Module as ModuleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use app\service\desktop\Module as ModuleService;
use app\service\User as UserService;
use Sunqianhu\Helper\ArrayHandler;
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

    /**
     * 得到用户的路由
     * @param $userId
     * @return array
     */
    public function getRoutes($userId)
    {
        $routes = [];
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
        if (empty($roleIds)) {
            return $routes;
        }

        //页面
        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.id,m.module_id,m.type_id,m.name,m.path,m.key,m.component,m.keep_alive,m.layout')
            ->where('m.type_id', 'in', '1,2')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->group('m.id')
            ->select();
        if ($moduleModels->isEmpty()) {
            return $routes;
        }

        $modules = $moduleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');
        $moduleService = new ModuleService();
        $mainFirstPageId = $moduleService->getMainFirstPageId($treeModules);
        $blankFirstPageId = $moduleService->getBlankFirstPageId($treeModules);

        foreach ($moduleModels as $moduleModel) {
            if (
                $moduleModel->type_id != 2 ||
                $moduleModel->path === '' ||
                $moduleModel->name === '' ||
                $moduleModel->component === ''
            ) {
                continue;
            }

            //父页面跳转
            $parentRedirect = '';
            if ($moduleModel->id == $mainFirstPageId) {
                $parentRedirect = 'main';
            }
            if ($moduleModel->id == $blankFirstPageId) {
                $parentRedirect = 'blank';
            }

            $route = [];
            $route['path'] = $moduleModel->path;
            $route['name'] = $moduleModel->key;
            $route['component'] = $moduleModel->component;
            $route['layout'] = $moduleModel->layout;
            $route['parent_redirect'] = $parentRedirect;
            $route['meta']['name'] = $moduleModel->name;
            $route['meta']['keep_alive'] = $moduleModel->keep_alive == 1;
            $routes[] = $route;
        }

        return $routes;
    }

    /**
     * 获取用户的权限
     * @return mixed
     */
    public function getPermissions($userId)
    {
        $permissions = [];
        $userService = new UserService();
        $roleIds = $userService->getRoleIds($userId);
        if (empty($roleIds)) {
            return $permissions;
        }

        //模块
        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.key')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->group('m.id')
            ->select();
        if ($moduleModels->isEmpty()) {
            return $permissions;
        }

        foreach ($moduleModels as $moduleModel) {
            $permissions[] = $moduleModel->key;
        }
        if(!empty($permissions)){
            $permissions = array_unique($permissions);
        }

        return $permissions;
    }
}