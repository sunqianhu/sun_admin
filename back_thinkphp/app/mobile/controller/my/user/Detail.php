<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\model\UserModel;
use app\service\mobile\SessionService;

class Detail extends Base
{
    public $isApiAuth = false;

    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $userModel = UserModel::field('id,avatar,name,department_id,phone')
            ->append(['avatar_url', 'department_name'])
            ->find($this->session->userId);
        if(empty($userModel)){
            return $this->error('用户不存在');
        }
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 退出
     * @return \think\Response
     */
    public function logout()
    {
        $sessionService = new SessionService();
        $sessionService->logout($this->session->token);

        return $this->success("退出登录成功");
    }
}