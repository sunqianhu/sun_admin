<?php

namespace app\mobile\controller;

use app\helper\user\UserMobilePermissionHelper;
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
        $userMobilePermissionHelper = new UserMobilePermissionHelper();
        $permissions = $userMobilePermissionHelper->getPermissionKeys($this->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
    }
}