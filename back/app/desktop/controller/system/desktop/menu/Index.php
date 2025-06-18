<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use Sunqianhu\Helper\thinkphp\Crud;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use think\Response;

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
        $menus = $menuModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeMenu = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->getSuccessResonse('获取成功', $treeMenu);
    }

    /**
     * 删除
     * @return Response
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $menuCrud = new Crud(MenuModel::class);
        try{
            $menuCrud->delete($id);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('删除成功');
    }
}