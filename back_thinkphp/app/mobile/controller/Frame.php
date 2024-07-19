<?php

namespace app\mobile\controller;

use app\service\user\Mobile as MobileService;

/**
 * 框架
 */
class Frame extends Base
{
    /**
     * 获取权限
     * @return void
     */
    public function getPermissions()
    {
        $mobileService = new MobileService();
        $permissions = $mobileService->getPermissionKeys($this->session->userId);

        return $this->success('获取成功', $permissions);
    }
}