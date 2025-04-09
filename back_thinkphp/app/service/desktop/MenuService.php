<?php

namespace app\service\desktop;

use app\model\desktop\MenuModel;
use Sunqianhu\Helper\ArrayHandler;

class MenuService
{
    /**
     * 得到树形菜单
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $menuModels = MenuModel::field('id,menu_id,name,url')
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
    }

    /**
     * 得到名称和url的树形菜单
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getNameUrlTreeMenu()
    {
        $menuModels = MenuModel::field('id, menu_id, name, url')
            ->order('sort', 'asc')
            ->append(['name_url'])
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
    }

    /**
     * 得到子菜单id
     * @param $id
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getChildMenuIds($id){
        $menuModels = MenuModel::where('menu_id', $id)
            ->select();
        $ids = [];
        foreach($menuModels as $menuModel){
            $ids[] = $menuModel->id;
            $ids = array_merge($ids, $this->getChildMenuIds($menuModel->id));
        }
        return $ids;
    }

    /**
     * 是否有子菜单
     * @param $id
     * @return bool
     */
    public function hasChildrenMenu($id){
        $menuModel = MenuModel::field('id')
            ->where('menu_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($menuModel)){
            return true;
        }
        return false;
    }
}