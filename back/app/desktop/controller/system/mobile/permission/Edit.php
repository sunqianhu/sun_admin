<?php

namespace app\desktop\controller\system\mobile\permission;

use app\desktop\controller\Base;
use app\model\mobile\PermissionModel;
use Sunqianhu\Helper\thinkphp\Crud;
use app\validate\IdValidate;
use app\validate\mobile\PermissionValidate;
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

        $permissionModel = PermissionModel::field('id,permission_id,name,key,api_string,sort')->find($id);
        if (empty($permissionModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $permission = $permissionModel->toArray();

        return $this->getSuccessResonse('获取成功', $permission);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'permission_id' => 0, 'name'=>'', 'key'=>'', 'api_string'=>'', 'sort']);

        //验证
        try {
            validate(PermissionValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        if($post['id'] == $post['permission_id']){
            return $this->getErrorResponse('上级权限不能和此权限相同');
        }

        $permissionCrud = new Crud(PermissionModel::class);
        try{
            $permissionCrud->update($post['id'], $post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('修改成功');
    }
}