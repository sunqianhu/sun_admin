<?php

namespace app\desktop\controller\layouts\side\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;

class Detail extends Base
{
    /**
     * 得到用户
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getUser()
    {
        $userModel = UserModel::field('id,account,name,phone,login_time,login_ip,department_id')
            ->append(['department_name'])
            ->find($this->session->userId);
        $user = $userModel->toArray();
        return $this->success('获取成功', $user);
    }
}