<?php

namespace app\desktop\controller;

use app\service\User as UserService;

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
        $userService = new UserService();
        $routes = $userService->getRoutes($this->user->id);

        return $this->success('获取成功', $routes);
    }

    /**
     * 获取模块
     * @return void
     */
    public function getModules()
    {
        $userService = new UserService();
        $permissions = $userService->getPermissions($this->user->id);

        return $this->success('获取成功', $permissions);
    }
}