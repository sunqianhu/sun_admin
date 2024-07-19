<?php

namespace app\mobile\controller;

use app\model\User as UserModel;

/**
 * 框架
 */
class Index extends Base
{
    /**
     * 初始化
     * @return void
     */
    public function init()
    {
        $userModel = UserModel::field('avatar,name,department_id')
            ->append(['avatar_url', 'department_name'])
            ->find($this->session->userId);
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->success('获取成功', $data);
    }
}