<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\CrudService;

class RoleSelect extends Base
{
    public $isApiAuth = false;

    /**
     * 得到角色列表
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoles()
    {
        $roleCrudService = new CrudService(RoleModel::class);
        $roles = $roleCrudService->selectAll();
        return $this->success('获取成功', $roles);
    }
}