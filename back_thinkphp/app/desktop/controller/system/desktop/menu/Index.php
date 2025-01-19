<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use app\service\desktop\MenuService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 树得到菜单
     */
    public function getTreeMenu()
    {
        $get = $this->request->get(['name']);
        $query = MenuModel::field('id,menu_id,name,url,icon,sort');
        if (isset($get['name'])) {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('sort', 'asc');
        $menuModels = $query->select();
        $menuArrays = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeMenu = $arrayHandler->convertTree($menuArrays, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenu);
    }

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menu = new MenuService();
        try{
            $menu->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}