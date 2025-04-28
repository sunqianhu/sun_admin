<?php

namespace app\desktop\controller\system\desktop\menu;

use app\desktop\controller\Base;
use app\model\desktop\MenuModel;
use app\service\CrudService;
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

        $menuCrudService = new CrudService(MenuModel::class);
        try {
            $menuCrudService->insert($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}