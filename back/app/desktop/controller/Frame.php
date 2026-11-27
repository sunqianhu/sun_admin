<?php

namespace app\desktop\controller;

use app\helper\user\PermissionHelper;
use app\helper\user\DesktopRouteHelper;
use app\helper\WatermarkHelper;
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
        $permissionHelper = new PermissionHelper();
        $permissions = $permissionHelper->getPermissionKeys($this->request->userId);
        return $this->getSuccessResponse('获取成功', $permissions);
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
        $desktopRouteHelper = new DesktopRouteHelper();
        $routes = $desktopRouteHelper->getRoutes($this->request->userId);
        return $this->getSuccessResponse('获取成功', $routes);
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
        if(empty($this->request->userId)){
            return $this->getErrorResponse('还没有登录');
        }

        $watermarkHelper = new WatermarkHelper();
        $watermark = $watermarkHelper->getWatermark($this->request->userId);

        return $this->getSuccessResponse('获取成功', $watermark);
    }
}