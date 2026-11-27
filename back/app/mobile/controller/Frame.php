<?php

namespace app\mobile\controller;

use app\helper\user\PermissionHelper;
use think\Response;

class Frame extends Base
{
    public bool $isApiAuth = false;

    /**
     * 获取权限
     * @return Response
     */
    public function getPermissions()
    {
        $permissionHelper = new PermissionHelper();
        $permissions = $permissionHelper->getPermissionKeys($this->request->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
    }
}