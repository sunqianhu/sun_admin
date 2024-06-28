<?php

namespace app\desktop\controller\main\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use think\exception\ValidateException;

class Password extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['password1', 'password2']);

        try {
            validate(MyValidate::class)->scene('edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($this->user->id);
        $userModel->password = md5($post['password1']);
        $userModel->save();

        return $this->success('修改成功');
    }
}