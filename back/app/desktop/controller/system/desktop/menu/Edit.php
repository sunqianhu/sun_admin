<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use Sunqianhu\Helper\thinkphp\Crud;
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

        return $this->getSuccessResonse('获取成功', $menu);
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
            return $this->getErrorResponse($exception->getError());
        }
        if($post['id'] == $post['menu_id']){
            return $this->getErrorResponse('上级菜单不能和此菜单相同');
        }

        $menuCrud = new Crud(MenuModel::class);
        try{
            $menuCrud->update($post['id'], $post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('修改成功');
    }
}