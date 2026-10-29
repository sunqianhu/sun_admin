<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\helper\user\UserPasswordHelper;
use app\validate\IdValidate;
use app\validate\user\UserPasswordEditValidate;
use Exception;
use think\exception\ValidateException;

class EditPassword extends Base
{
    /**
     * 修改
     */
    public function save()
    {

        $post = $this->request->post(['id', 'new_password1', 'new_password2']);

        try {
            validate(IdValidate::class)->check($post);
            $post['old_password'] = '1';
            validate(UserPasswordEditValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userPasswordHelper = new UserPasswordHelper();
        try{
            $userPasswordHelper->editPassword($post['id'], $post['new_password1']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}