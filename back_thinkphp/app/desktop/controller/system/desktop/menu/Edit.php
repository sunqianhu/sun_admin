<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use app\service\desktop\Menu;
use app\validate\desktop\MenuValidate;
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

        $menu = MenuModel::field('id,menu_id,name,url,icon,target,sort')->find($id);
        if (empty($menu)) {
            return $this->error('没有找到记录');
        }
        $menuArray = $menu->toArray();

        return $this->success('获取成功', $menuArray);
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

        $menu = new Menu();
        try{
            $menu->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}