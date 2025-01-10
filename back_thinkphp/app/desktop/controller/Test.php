<?php

namespace app\desktop\controller;

use app\model\UserModel;
use app\service\Children;
use app\service\UserRole;

class Test
{
    public function index()
    {
        $user = UserModel::query()->append(['department_name', 'RoleIds'])->find(1);

        print_r($user->toArray());
    }
}