<?php

namespace app\desktop\controller;

use app\service\desktop\DesktopUserService;
use app\service\WatermarkService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

/**
 * 框架
 */
class Frame extends Base
{
    public bool $isApiAuth = false;

    /**
     * 获取权限
     * @return Response
     */
    public function getPermissions()
    {
        $desktopUserService = new DesktopUserService();
        $permissions = $desktopUserService->getPermissionKeys($this->session->userId);
        return $this->success('获取成功', $permissions);
    }

    /**
     * 获取路由
     * @return Response
     */
    public function getRoutes()
    {
        $desktopUserService = new DesktopUserService();
        $routes = $desktopUserService->getRoutes($this->session->userId);
        return $this->success('获取成功', $routes);
    }

    /**
     * 得到水印
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getWatermark()
    {
        if(empty($this->session->userId)){
            return $this->error('还没有登录');
        }

        $watermarkService = new WatermarkService();
        $watermark = $watermarkService->getWatermark($this->session->userId);

        return $this->success('获取成功', $watermark);
    }
}