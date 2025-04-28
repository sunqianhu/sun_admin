<?php

namespace app\service\desktop;

use app\model\desktop\MenuModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class MenuService
{
    /**
     * 得到子菜单id
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getChildrenIds($id){
        $menuModels = MenuModel::field('id')
            ->where('menu_id', $id)
            ->select();
        $ids = [];
        foreach($menuModels as $menuModel){
            $ids[] = $menuModel->id;
            $ids = array_merge($ids, $this->getChildrenIds($menuModel->id));
        }
        return $ids;
    }

    /**
     * 得到树形菜单
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeMenu($id)
    {
        $ids = $this->getChildrenIds($id);
        $ids[] = $id;

        $menuModels = MenuModel::field('id,menu_id,name,url')
            ->whereIn('id', $ids)
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
    }

    /**
     * 是否有子菜单
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function hasChildren($id){
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