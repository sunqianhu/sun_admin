<?php

namespace app\helper\desktop;

use app\model\desktop\MenuModel;
use Exception;
use Sunqianhu\Helper\Arr;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class MenuHelper
{
    /**
     * 得到子菜单id
     * @param $id
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getAllMenuIds($id){
        $menuModels = MenuModel::field('id')
            ->where('menu_id', $id)
            ->select();
        $ids = [];
        foreach($menuModels as $menuModel){
            $ids[] = $menuModel->id;
            $ids = array_merge($ids, $this->getAllMenuIds($menuModel->id));
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
        $ids = $this->getAllMenuIds($id);
        $ids[] = $id;

        $menuModels = MenuModel::field('id,menu_id,name,url')
            ->whereIn('id', $ids)
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arr = new Arr();
        return $arr->toTree($menus, 'id', 'menu_id', 'children');
    }

    /**
     * 是否存在子菜单
     * @param $id
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistMenus($id){
        $menuModel = MenuModel::field('id')
            ->where('menu_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($menuModel)){
            return true;
        }
        return false;
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
    public function delete($id)
    {
        $menuModel = MenuModel::find($id);
        if(empty($menuModel)){
            throw new Exception('没有找到记录');
        }
        if($this->isExistMenus($id)){
            throw new Exception('存在子菜单，不能删除');
        }
        $menuModel->delete();
    }
}