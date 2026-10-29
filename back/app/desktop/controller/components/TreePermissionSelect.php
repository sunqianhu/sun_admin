<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\PermissionHelper;
use think\Response;

class TreePermissionSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树权限
     * @return Response
     */
    public function getTreePermission()
    {
        $get = $this->request->get(['permission_id' => 0]);
        if (!is_numeric($get['permission_id']) || $get['permission_id'] < 0) {
            return $this->getErrorResponse('permission_id参数错误');
        }
        $permissionHelper = new PermissionHelper();
        $treePermission = $permissionHelper->getTreePermission($get['permission_id']);
        return $this->getSuccessResponse('获取成功', $treePermission);
    }
}
