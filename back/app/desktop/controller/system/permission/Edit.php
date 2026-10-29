<?php

namespace app\desktop\controller\system\permission;

use app\desktop\controller\Base;
use app\helper\PermissionHelper;
use app\model\PermissionModel;
use app\validate\PermissionValidate;
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

        $permissionModel = PermissionModel::field('id,permission_id,name,key,apis_string,sort')->find($id);
        if (empty($permissionModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $permission = $permissionModel->toArray();

        return $this->getSuccessResponse('获取成功', $permission);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'permission_id' => 0, 'name'=>'', 'key'=>'', 'apis_string'=>'', 'sort']);

        try {
            validate(PermissionValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        try{
            $permissionHelper = new PermissionHelper();
            $permissionHelper->edit($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}
