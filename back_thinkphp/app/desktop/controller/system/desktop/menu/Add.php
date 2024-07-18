<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\service\desktop\Menu as MenuService;
use app\validate\desktop\Menu as MenuValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $menuService = new MenuService();
        $treeMenus = $menuService->getTreeMenus();

        $data = [
            'tree_menus' => $treeMenus
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['menu_id' => 0, 'name' => '', 'url' => '', 'icon' => '', 'target', 'sort']);

        //验证
        try {
            validate(MenuValidate::class)->scene('desktop_add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $menuService = new MenuService();
        try {
            $menuService->add($post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}