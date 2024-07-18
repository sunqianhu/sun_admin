<?php

namespace app\validate;

use think\Validate;

class Session extends Validate
{
    protected $rule = [
        'account'  =>  'require',
        'password' =>  'require'
    ];
    protected $message = [
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空'
    ];
    protected $scene = [
        'desktop_login' => ['account', 'password']
    ];
}