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
        $get = $this->request->get(['permission_id'=>0]);
        if(!is_numeric($get['permission_id'])){
            return $this->getErrorResponse('menu_id参数错误');
        }

        $permissionService = new PermissionService();
        $treePermission = $permissionService->getTreePermission($get['permission_id']);
        return $this->getSuccessResonse('获取成功', $treePermission);
    }
}