<?php

namespace app\desktop\controller\system\desktop\permission;

use app\desktop\controller\Base;
use app\model\desktop\PermissionModel;
use app\service\desktop\Permission;
use app\validate\desktop\PermissionValidate;
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
        $permission = $permission->toArray();

        $permission = new Permission();
        $treePermission = $permission->getTreePermission();

        $data = [
            'permission' => $permission,
            'tree_permissions' => $treePermission
        ];
        return $this->success('获取成功', $data);
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
            return $this->error('上级权限不能和权限单相同');
        }

        $permission = new Permission();
        try{
            $permission->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}