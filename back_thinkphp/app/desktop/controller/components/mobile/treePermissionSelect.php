<?php

namespace app\desktop\controller\components\mobile;

use app\desktop\controller\Base;
use app\service\mobile\PermissionService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class treePermissionSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树权限
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreePermission()
    {
        $permissionService = new PermissionService();
        $treePermission = $permissionService->getTreePermission();
        return $this->getSuccessResonse('获取成功', $treePermission);
    }
}