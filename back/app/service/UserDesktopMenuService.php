<?php

namespace app\service;

use app\model\desktop\MenuModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class UserDesktopMenuService
{
    /**
     * 得到树形菜单
     * @param $userId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeMenu($userId){
        $userRoleService = new UserRoleService();
        $roleIds = $userRoleService->getRoleIds($userId);
        if(empty($roleIds)){
            return [];
        }

        $menuModels = MenuModel::alias('m')
            ->field('m.*')
            ->join('role_desktop_menu rdm', 'm.id = rdm.menu_id')
            ->where('rdm.role_id', 'in', $roleIds)
            ->order('m.sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
    }
}