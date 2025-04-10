<?php

namespace app\desktop\controller\system\mobile\permission;

use app\desktop\controller\Base;
use app\model\mobile\PermissionModel;
use app\service\CrudService;
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
            return $this->error($exception->getError());
        }
        $id = $get['id'];

        $permissionModel = PermissionModel::field('id,permission_id,name,key,api_string,sort')->find($id);
        if (empty($permissionModel)) {
            return $this->error('没有找到记录');
        }
        $permission = $permissionModel->toArray();

        return $this->success('获取成功', $permission);
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
            return $this->error($exception->getError());
        }
        if($post['id'] == $post['permission_id']){
            return $this->error('上级权限不能和此权限相同');
        }

        $permissionCrudService = new CrudService(PermissionModel::class);
        try{
            $permissionCrudService->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}