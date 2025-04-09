<?php

namespace app\mobile\controller;

use app\model\UserModel;

class Index extends Base
{
    public $noApiAuthActions = ['init'];

    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $userModel = UserModel::field('avatar,name,department_id')
            ->append(['avatar_url', 'department_name'])
            ->find($this->session->userId);
        if(empty($user)){
            return $this->error('用户不存在');
        }
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->success('获取成功', $data);
    }
}