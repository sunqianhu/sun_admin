<?php

namespace app\mobile\controller;

use app\helper\user\UserPermissionHelper;
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
        $userPermissionHelper = new UserPermissionHelper();
        $permissions = $userPermissionHelper->getPermissionKeys($this->request->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
    }
}