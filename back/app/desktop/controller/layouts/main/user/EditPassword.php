<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\service\user\UserPasswordService;
use app\validate\user\TwoPasswordValidate;
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
        $post = $this->request->post(['password1', 'password2']);

        try {
            validate(TwoPasswordValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userPasswordService = new UserPasswordService();
        try{
            $userPasswordService->editPassword($this->userId, $post['password1']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}