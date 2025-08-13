<?php

namespace app\mobile\controller;

use app\service\mobile\MobileUserService;
use app\service\UserMobilePermissionService;
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
        $userMobilePermissionService = new UserMobilePermissionService();
        $permissions = $userMobilePermissionService->getPermissionKeys($this->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
    }
}