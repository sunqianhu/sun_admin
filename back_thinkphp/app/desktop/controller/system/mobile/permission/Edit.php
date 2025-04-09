<?php

namespace app\desktop\controller\system\mobile\permission;

use app\desktop\controller\Base;
use app\model\mobile\PermissionModel;
use app\service\mobile\PermissionService;
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
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $permission = PermissionModel::field('id,permission_id,name,key,api_string,sort')->find($id);
        if (empty($permission)) {
            return $this->error('没有找到记录');
        }
        $permissionArray = $permissionService->toArray();

        return $this->success('获取成功', $permissionArray);
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

        $permissionService = new PermissionService();
        try{
            $permissionService->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}