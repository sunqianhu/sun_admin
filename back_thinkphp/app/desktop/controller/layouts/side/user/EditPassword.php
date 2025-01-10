<?php

namespace app\desktop\controller\layouts\side\user;

use app\desktop\controller\Base;
use app\service\User;
use app\validate\UserValidate;
use think\exception\ValidateException;

class EditPassword extends Base
{
    public $isApiAuth = false;

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['password1', 'password2']);

        try {
            validate(UserValidate::class)->scene('my_edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $user = new User();
        $user->editPassword($this->session->userId, $post['password1']);

        return $this->success('修改成功');
    }
}