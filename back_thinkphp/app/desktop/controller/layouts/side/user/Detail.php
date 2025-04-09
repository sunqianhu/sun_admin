<?php

namespace app\desktop\controller\layouts\side\user;

use app\desktop\controller\Base;
use app\model\UserModel;

class Detail extends Base
{
    public $isApiAuth = false;

    /**
     * 得到用户
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getUser()
    {
        $userModel = UserModel::field('id,account,name,phone,last_login_time,last_login_ip,department_id')
            ->append(['department_name'])
            ->find($this->session->userId);
        $user = $userModel->toArray();
        return $this->success('获取成功', $user);
    }
}