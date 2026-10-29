<?php

namespace app\desktop\controller\system\permission;

use app\desktop\controller\Base;
use app\helper\PermissionHelper;
use app\validate\PermissionValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['permission_id' => 0, 'name' => '', 'key' => '', 'api_string' => '', 'sort']);

        try {
            validate(PermissionValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            $permissionHelper = new PermissionHelper();
            $permissionHelper->add($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
