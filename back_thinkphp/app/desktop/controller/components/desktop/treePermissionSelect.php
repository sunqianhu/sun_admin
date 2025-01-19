<?php

namespace app\desktop\controller\components\desktop;

use app\desktop\controller\Base;
use app\service\desktop\PermissionService;

class treePermissionSelect extends Base
{
    public $noApiAuthActions = [
        'getTreePermission'
    ];

    /**
     * 得到树权限
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreePermission()
    {
        $permission = new PermissionService();
        $treePermission = $permission->getTreePermission();
        return $this->success('获取成功', $treePermission);
    }
}