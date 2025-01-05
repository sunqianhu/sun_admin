<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\model\UserModel;
use app\service\mobile\Session;

class Detail extends Base
{
    /**
     * 初始化
     * @return void
     */
    public function init()
    {
        $userModel = UserModel::field('id,avatar,name,department_id,phone')
            ->append(['avatar_url', 'department_name'])
            ->find($this->session->userId);
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $session = new Session();
        $session->logout($this->session->token);

        return $this->success("退出成功");
    }
}