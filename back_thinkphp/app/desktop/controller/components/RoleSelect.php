<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\Role;

class RoleSelect extends Base
{
    public $noApiAuthActions = [
        'getRoles'
    ];

    /**
     * 得到角色列表
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getRoles()
    {
        $role = new Role();
        $roles = $role->fetchAll();
        return $this->success('获取成功', $roles);
    }
}