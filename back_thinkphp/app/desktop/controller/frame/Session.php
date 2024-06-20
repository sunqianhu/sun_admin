<?php

namespace app\desktop\controller\frame;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use app\service\desktop\session\Jwt;

/**
 * 登录
 */
class Session extends Base
{

    /**
     * 登录
     * @return string
     */
    public function login()
    {




        $data = [
            'token' => $token,
            'user_id' => $userModel->id
        ];
        return $this->success("登录成功", $data);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $userModel = UserModel::find($this->user->id);
        $jwt = new Jwt();
        $jwt->deleteToken($userModel->id);

        return $this->success("退出成功");
    }
}