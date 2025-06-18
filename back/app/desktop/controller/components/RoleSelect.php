<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\RoleModel;
use Sunqianhu\Helper\thinkphp\Crud;
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
        $roleCrud = new Crud(RoleModel::class);
        $roles = $roleCrud->selectAll();
        return $this->getSuccessResonse('获取成功', $roles);
    }
}