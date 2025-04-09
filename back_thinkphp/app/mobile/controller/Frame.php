<?php

namespace app\mobile\controller;

use app\service\mobile\MobileUserService;

/**
 * 框架
 */
class Frame extends Base
{
    public $isApiAuth = false;

    /**
     * 获取权限
     * @return \think\Response
     */
    public function getPermissions()
    {
        $mobileUserService = new MobileUserService();
        $permissions = $mobileUserService->getPermissionKeys($this->session->userId);
        return $this->success('获取成功', $permissions);
    }
}