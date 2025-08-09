<?php

namespace app\mobile\controller;

use app\service\mobile\MobileUserService;
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
        $mobileUserService = new MobileUserService();
        $permissions = $mobileUserService->getPermissionKeys($this->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
    }
}