<?php

namespace app\desktop\controller;

use app\service\user\Desktop as DesktopService;

/**
 * 框架
 */
class Frame extends Base
{
    /**
     * 获取路由
     * @return void
     */
    public function getRoutes()
    {
        $desktopService = new DesktopService();
        $routes = $desktopService->getRoutes($this->session->user->id);

        return $this->success('获取成功', $routes);
    }

    /**
     * 获取权限
     * @return void
     */
    public function getPermissions()
    {
        $desktopService = new DesktopService();
        $permissions = $desktopService->getPermissionKeys($this->session->user->id);

        return $this->success('获取成功', $permissions);
    }
}