<?php

namespace app\desktop\controller;

use app\model\User as UserModel;

class Main
{
    public function init()
    {

    }

    public function getUserInfo()
    {

    }

    public function initEditAvatar()
    {

    }

    public function saveEditAvatar()
    {

    }

    public function editPassword()
    {

    }

    /**
     * 获取水印
     * @return void
     */
    public function getWatermark()
    {
        $userModel = UserModel::field('id,name')->find($this->user->id);
        if (empty($userModel)) {
            return $this->error('没有找到用户记录');
        }
        $data = [
            'id' => $userModel->id,
            'name' => $userModel->name,
            'time' => date('Y-m-d H:i:s')
        ];
        return $this->success('获取成功', $data);
    }
}