<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\helper\user\UserPasswordHelper;
use app\model\UserModel;
use app\validate\user\UserPasswordEditValidate;
use Exception;
use think\exception\ValidateException;

class EditPassword extends Base
{
    public bool $isApiAuth = false;

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['old_password', 'password1', 'password2']);

        try {
            validate(UserPasswordEditValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userPasswordHelper = new UserPasswordHelper();
        try {
            $userModel = UserModel::field('id,password')->find($this->userId);
            if (empty($userModel)) {
                return $this->getErrorResponse('没有找到用户记录');
            }
            if (!password_verify($post['old_password'], $userModel->password)) {
                return $this->getErrorResponse('原密码错误');
            }

            $userPasswordHelper->editPassword($this->userId, $post['password1']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}
