<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\helper\desktop\PermissionHelper;
use think\Response;

class treePermissionSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树权限
     * @return Response
     */
    public function getTreePermission()
    {
        $permissionHelper = new PermissionHelper();
        $treePermission = $permissionHelper->getTreePermission(0);
        return $this->getSuccessResponse('获取成功', $treePermission);
    }
}