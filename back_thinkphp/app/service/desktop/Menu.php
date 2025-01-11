<?php

namespace app\service\desktop;

use app\model\desktop\MenuModel;
use app\service\Curd;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Menu extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(MenuModel::class);
    }

    /**
     * 得到树形菜单
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenu()
    {
        $menus = MenuModel::field('id,menu_id,name,url')
            ->order('sort', 'asc')
            ->select();
        $menuArrays = $menus->toArray();

        $arrayHandler = new ArrayHandler();
        $treeMenu = $arrayHandler->convertTree($menuArrays, 'id', 'menu_id', 'children');
        return $treeMenu;
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
        $menus = MenuModel::field('id, menu_id, name, url')
            ->order('sort', 'asc')
            ->append(['name_url'])
            ->select();
        $menuArrays = $menus->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($menuArrays, 'id', 'menu_id', 'children');
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
        $menus = MenuModel::where('menu_id', $id)
            ->select();
        $ids = [];
        foreach($menus as $menu){
            $ids[] = $menu->id;
            $ids = array_merge($ids, $this->getChildMenuIds($menu->id));
        }
        return $ids;
    }

    /**
     * 是否有子菜单
     * @param $id
     * @return void
     */
    public function hasChildrenMenu($id){
        $menu = MenuModel::where('menu_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($menu)){
            return true;
        }
        return false;
    }
}