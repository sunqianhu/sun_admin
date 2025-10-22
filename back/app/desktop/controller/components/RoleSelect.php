<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\RoleModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class RoleSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到角色列表
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getRoles()
    {
        $roleModels = RoleModel::field('id,name')
            ->select();
        $roles = $roleModels->toArray();
        return $this->getSuccessResponse('获取成功', $roles);
    }
}