<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\helper\user\UserPasswordHelper;
use app\validate\user\UserPasswordEditValidate;
use Exception;
use think\exception\ValidateException;

class PasswordEdit extends Base
{
    public bool $isApiAuth = false;

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['old_password', 'new_password1', 'new_password2']);

        try {
            validate(UserPasswordEditValidate::class)->scene('my_edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userPasswordHelper = new UserPasswordHelper();
        try {
            if (!$userPasswordHelper->checkPassword($this->request->userId, $post['old_password'])) {
                return $this->getErrorResponse('原密码错误');
            }
            $userPasswordHelper->editPassword($this->request->userId, $post['new_password1']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}
