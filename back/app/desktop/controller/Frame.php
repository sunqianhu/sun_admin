<?php

namespace app\desktop\controller;

use app\service\desktop\DesktopUserService;
use app\service\UserDesktopPermissionService;
use app\service\UserDesktopRouteService;
use app\service\WatermarkService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
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
        $userDesktopPermissionService = new UserDesktopPermissionService();
        $permissions = $userDesktopPermissionService->getPermissionKeys($this->userId);
        return $this->getSuccessResonse('获取成功', $permissions);
    }

    /**
     * 获取路由
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getRoutes()
    {
        $userDesktopRouteService = new UserDesktopRouteService();
        $routes = $userDesktopRouteService->getRoutes($this->userId);
        return $this->getSuccessResonse('获取成功', $routes);
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
        if(empty($this->userId)){
            return $this->getErrorResponse('还没有登录');
        }

        $watermarkService = new WatermarkService();
        $watermark = $watermarkService->getWatermark($this->userId);

        return $this->getSuccessResonse('获取成功', $watermark);
    }
}