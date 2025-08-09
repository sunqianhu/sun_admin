<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\service\desktop\PermissionService;
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
        $permissionService = new PermissionService();
        $treePermission = $permissionService->getTreePermission(0);
        return $this->getSuccessResonse('获取成功', $treePermission);
    }
}