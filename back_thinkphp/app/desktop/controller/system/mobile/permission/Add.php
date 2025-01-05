<?php

namespace app\desktop\controller\system\mobile\permission;

use app\desktop\controller\Base;
use app\service\mobile\Permission as PermissionService;
use app\validate\mobile\PermissionValidate as PermissionValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $permissionService = new PermissionService();
        $treePermissions = $permissionService->getTreePermissions();

        $data = [
            'tree_permissions' => $treePermissions
        ];
        return $this->success('获取成功', $data);
    }

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
            return $this->error($exception->getError());
        }

        $permissionService = new PermissionService();
        try {
            $permissionService->add($post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}