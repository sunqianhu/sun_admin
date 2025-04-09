<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use app\service\CrudService;
use app\service\desktop\MenuService;
use app\validate\desktop\MenuValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        $id = $get['id'];

        $menuModel = MenuModel::field('id,menu_id,name,url,icon,target,sort')->find($id);
        if (empty($menuModel)) {
            return $this->error('没有找到记录');
        }
        $menu = $menuModel->toArray();

        return $this->success('获取成功', $menu);
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
            return $this->error('上级菜单不能和此菜单相同');
        }

        $menuCrudService = new CrudService(MenuModel::class);
        try{
            $menuCrudService->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}