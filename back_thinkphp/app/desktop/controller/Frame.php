<?php

namespace app\desktop\controller;

use app\service\user\Desktop as DesktopService;
use app\service\Watermark as WatermarkService;

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
        $desktopService = new DesktopService();
        $permissions = $desktopService->getPermissionKeys($this->session->userId);

        return $this->success('获取成功', $permissions);
    }

    /**
     * 获取路由
     * @return void
     */
    public function getRoutes()
    {
        $desktopService = new DesktopService();
        $routes = $desktopService->getRoutes($this->session->userId);

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

        $watermarkService = new WatermarkService();
        $watermarkEntity = $watermarkService->getWatermark($this->session->userId);
        $watermark = $watermarkEntity->toArray();

        return $this->success('获取成功', $watermark);
    }
}