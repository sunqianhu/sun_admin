<?php

namespace app\desktop\controller;

use app\service\desktop\DesktopUserService;
use app\service\WatermarkService;

/**
 * 框架
 */
class Frame extends Base
{
    public $isApiAuth = false;

    /**
     * 获取权限
     * @return void
     */
    public function getPermissions()
    {
        $desktopUser = new DesktopUserService();
        $permissions = $desktopUser->getPermissionKeys($this->session->userId);

        return $this->success('获取成功', $permissions);
    }

    /**
     * 获取路由
     * @return void
     */
    public function getRoutes()
    {
        $desktopUser = new DesktopUserService();
        $routes = $desktopUser->getRoutes($this->session->userId);

        return $this->success('获取成功', $routes);
    }

    /**
     * 得到水印
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getWatermark()
    {
        if(empty($this->session->userId)){
            return $this->error('还没有登录');
        }

        $watermark = new WatermarkService();
        $watermark = $watermark->getWatermark($this->session->userId);

        return $this->success('获取成功', $watermark);
    }
}