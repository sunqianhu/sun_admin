<?php

namespace app\desktop\controller\main\user;

use app\desktop\controller\Base;
use app\service\User as UserService;
use app\validate\user\EditPassword as EditPasswordValidate;
use think\exception\ValidateException;

class EditPassword extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['password1', 'password2']);

        try {
            validate(EditPasswordValidate::class)->scene('desktop_main_edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userService = new UserService();
        $userService->editPassword($this->session->user->id, $post['password1']);

        return $this->success('修改成功');
    }
}