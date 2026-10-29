<?php

namespace app\validate\user;

use think\Validate;

class UserPasswordEditValidate extends Validate
{
    protected $rule = [
        'old_password' =>  'require',
        'new_password1' =>  'require|min:10|passwordStrength',
        'new_password2' =>  'require|confirm:password1'
    ];
    protected $message = [
        'old_password.require' => '原密码不能为空',
        'new_password1.require' => '新密码不能为空',
        'new_password1.min' => '密码长度不能小于10位',
        'new_password1.passwordStrength' => '密码必须包含字母数字，长度大于10位',
        'new_password2.require' => '确认新密码不能为空',
        'new_password2.confirm' => '两次输入密码不相同'
    ];

    /**
     * 密码强度
     * @param $value
     * @param $rule
     * @param $data
     * @return bool
     */
    protected function passwordStrength($value, $rule, $data)
    {
        $pattern = '/^(?=.*[a-zA-Z])(?=.*\d).+$/';
        if (!preg_match($pattern, $value)) {
            return false;
        }
        if(strlen($value) < 10){
            return false;
        }
        return true;
    }
}