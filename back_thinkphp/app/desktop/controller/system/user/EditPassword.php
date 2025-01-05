<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\service\User as UserServer;
use app\validate\user\EditPasswordValidate as EditPasswordValidate;
use Exception;
use think\exception\ValidateException;

class EditPassword extends Base
{
    /**
     * 修改
     */
    public function save()
    {

        $post = $this->request->post(['id', 'password1', 'password2']);

        try {
            validate(EditPasswordValidate::class)->scene('edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $userServer = new UserServer();
            $userServer->editPassword($post['id'], $post['password1']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}