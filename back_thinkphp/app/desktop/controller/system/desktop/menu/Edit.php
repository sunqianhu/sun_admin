<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use app\service\desktop\Menu as MenuService;
use app\validate\desktop\MenuValidate as MenuValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menuModel = MenuModel::field('id,menu_id,name,url,icon,target,sort')->find($id);
        if (empty($menuModel)) {
            return $this->error('没有找到记录');
        }
        $menu = $menuModel->toArray();

        $menuService = new MenuService();
        $treeMenus = $menuService->getTreeMenus();

        $data = [
            'menu' => $menu,
            'tree_menus' => $treeMenus
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'menu_id' => 0, 'name'=>'', 'url'=>'', 'icon'=>'', 'target', 'sort']);

        //验证
        try {
            validate(MenuValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if($post['id'] == $post['menu_id']){
            return $this->error('上级菜单不能和本菜单相同');
        }

        $menuService = new MenuService();
        try{
            $menuService->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}