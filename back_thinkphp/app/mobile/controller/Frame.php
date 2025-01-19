<?php

namespace app\mobile\controller;

use app\service\mobile\MobileUserService as Mobile;

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
        $mobile = new Mobile();
        $permissions = $mobile->getPermissionKeys($this->session->userId);

        return $this->success('获取成功', $permissions);
    }
}