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
     * 得到id
     * @param $name
     * @return int
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getId($name){
        $menu = MenuModel::where('name', $name)
            ->find();
        if(empty($menu)){
            return 0;
        }
        return $menu->id;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $menu = new MenuModel();
        $menu->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    public function edit($id, $data){
        $menu = MenuModel::find($id);
        if(empty($menu)){
            throw new Exception('没有找到记录');
        }
        $menu->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function delete($id){
        $menu = MenuModel::find($id);
        if(empty($menu)){
            throw new Exception('没有找到菜单记录');
        }
        if($this->hasChildrenMenu($id)){
            throw new Exception('该菜单存在子菜单不能删除');
        }
        $menu->delete();
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