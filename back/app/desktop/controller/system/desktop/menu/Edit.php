<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\helper\desktop\MenuHelper;
use app\model\desktop\MenuModel;
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
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        $menuModel = MenuModel::field('id,menu_id,name,url,icon,target,sort')->find($id);
        if (empty($menuModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $menu = $menuModel->toArray();

        return $this->getSuccessResponse('获取成功', $menu);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'menu_id' => 0, 'name'=>'', 'url'=>'', 'icon'=>'', 'target', 'sort']);

        try {
            validate(MenuValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $menuHelper = new MenuHelper();
        $menuIds = $menuHelper->getAllMenuIds($post['id']);
        $menuIds[] = $post['id'];
        if(in_array($post['menu_id'], $menuIds)){
            return $this->getErrorResponse('上级菜单不能是本菜单或本菜单的子孙菜单');
        }

        $menuModel = MenuModel::find($post['id']);
        if(empty($menuModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $menuModel->save($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}