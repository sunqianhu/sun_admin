<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use think\exception\ValidateException;

class EditPassword extends Base
{
    /**
     * 修改
     */
    public function edit()
    {

        $post = $this->request->post(['id', 'password1', 'password2']);

        try {
            validate(UserValidate::class)->scene('edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($post['id']);
        if(empty($userModel)){
            return $this->error('没有找到用户记录');
        }
        $userModel->password = md5($post['password1']);
        $userModel->save();

        return $this->success('修改成功');
    }
}