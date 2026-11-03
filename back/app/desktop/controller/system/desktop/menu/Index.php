<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\helper\desktop\MenuHelper;
use app\model\desktop\MenuModel;
use Exception;
use Sunqianhu\Helper\Arr;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
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

        $arr = new Arr();
        $treeMenu = $arr->toTree($menus, 'id', 'menu_id', 'children');

        return $this->getSuccessResponse('获取成功', $treeMenu);
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

        try{
            $menuHelper = new MenuHelper();
            $menuHelper->delete($id);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}