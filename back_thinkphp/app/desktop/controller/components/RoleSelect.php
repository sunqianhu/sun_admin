<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\RoleModel;
use app\service\CrudService;
use think\Response;

class RoleSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到角色列表
     * @return Response
     */
    public function getRoles()
    {
        $roleCrudService = new CrudService(RoleModel::class);
        $roles = $roleCrudService->selectAll();
        return $this->getSuccessResonse('获取成功', $roles);
    }
}