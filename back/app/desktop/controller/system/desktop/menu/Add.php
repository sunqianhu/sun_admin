<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use Sunqianhu\Helper\thinkphp\Crud;
use app\validate\desktop\MenuValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['menu_id' => 0, 'name' => '', 'url' => '', 'icon' => '', 'target', 'sort']);

        //验证
        try {
            validate(MenuValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $menuCrud = new Crud(MenuModel::class);
        try {
            $menuCrud->insert($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}