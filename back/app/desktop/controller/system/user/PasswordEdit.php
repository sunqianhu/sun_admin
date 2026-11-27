<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\helper\user\PasswordHelper;
use app\validate\IdValidate;
use app\validate\user\UserPasswordEditValidate;
use Exception;
use think\exception\ValidateException;

class PasswordEdit extends Base
{
    /**
     * 修改
     */
    public function save()
    {

        $post = $this->request->post(['user_id', 'new_password1', 'new_password2']);

        try {
            validate(UserPasswordEditValidate::class)->scene('default')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $passwordHelper = new PasswordHelper();
        try{
            $passwordHelper->editPassword($post['user_id'], $post['new_password1']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}
