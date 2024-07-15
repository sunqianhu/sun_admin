<?php

namespace app\service\desktop;

use app\model\desktop\Menu as MenuModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Menu
{
    /**
     * 得到树形菜单
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenus()
    {
        $menuModels = MenuModel::field('id, menu_id, name, url')
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
        return $treeMenus;
    }

    /**
     * 得到带名称和url的树形菜单
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeMenusWithNameUrl()
    {
        $menuModels = MenuModel::field('id, menu_id, name, url')
            ->order('sort', 'asc')
            ->append(['name_url'])
            ->select();
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');
        return $treeMenus;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $menuModel = new MenuModel();
        $menuModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit($id, $data){
        $menuModel = MenuModel::find($id);
        if(empty($menuModel)){
            throw new Exception('没有找到记录');
        }
        $menuModel->save($data);
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
        $menuModel = MenuModel::find($id);
        if(empty($menuModel)){
            throw new Exception('没有找到记录');
        }
        if($this->hasChildrenMenu($id)){
            throw new Exception('存在子菜单不能删除');
        }
        $menuModel->delete();
    }

    /**
     * 是否有子菜单
     * @param $id
     * @return void
     */
    public function hasChildrenMenu($id){
        $menuModel = MenuModel::where('menu_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($menuModel)){
            return true;
        }
        return false;
    }
}