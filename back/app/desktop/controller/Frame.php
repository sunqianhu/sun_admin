<?php

namespace app\desktop\controller;

use app\helper\user\UserPermissionHelper;
use app\helper\user\UserDesktopRouteHelper;
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
        $userPermissionHelper = new UserPermissionHelper();
        $permissions = $userPermissionHelper->getPermissionKeys($this->userId);
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
        $userDesktopRouteHelper = new UserDesktopRouteHelper();
        $routes = $userDesktopRouteHelper->getRoutes($this->userId);
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
        if(empty($this->userId)){
            return $this->getErrorResponse('还没有登录');
        }

        $watermarkHelper = new WatermarkHelper();
        $watermark = $watermarkHelper->getWatermark($this->userId);

        return $this->getSuccessResponse('获取成功', $watermark);
    }
}