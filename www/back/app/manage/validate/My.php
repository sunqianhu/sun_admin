<?php

namespace app\manage\validate;

use think\Validate;

class My extends Validate
{
    protected $rule = [
        'avatar_base64_content'=>'require',
        'password1' =>  'require|min:6',
        'password2' =>  'require|confirm:password1'
    ];
    protected $message = [
        'avatar_base64_content.require' => '头像内容不能为空',
        'password1.require' => '新密码不能为空',
        'password1.min' => '新密码最少6位',
        'password2.require' => '确认新密码不能为空',
        'password2.confirm' => '两次输入密码不相同'
    ];
    protected $scene = [
        'edit_avatar'=>['avatar_base64_content'],
        'edit_password' => ['id', 'password1', 'password2'],
    ];
}