<?php

namespace app\desktop\controller\system\desktop\permission;

use app\desktop\controller\Base;
use app\model\desktop\PermissionModel;
use app\service\CrudService;
use app\validate\desktop\PermissionValidate;
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

        //验证
        try {
            validate(PermissionValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $permissionCrudService = new CrudService(PermissionModel::class);
        try {
            $permissionCrudService->insert($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}