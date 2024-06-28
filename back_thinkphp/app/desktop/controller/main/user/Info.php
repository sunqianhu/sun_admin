<?php

namespace app\desktop\controller\main\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;

class Info extends Base
{
    /**
     * 得到信息
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getInfo()
    {
        $userModel = UserModel::field('id,account,name,phone,login_time,login_ip,department_id')
            ->append(['department_name'])
            ->find($this->user->id);
        $user = $userModel->toArray();
        return $this->success('获取成功', $user);
    }
}