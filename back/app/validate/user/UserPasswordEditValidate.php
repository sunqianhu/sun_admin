<?php

namespace app\validate\user;

use think\Validate;

class UserPasswordEditValidate extends Validate
{
    protected $rule = [
        'user_id'=>  'require|number|egt:0',
        'old_password' =>  'require',
        'new_password1' =>  'require|min:10|passwordStrength',
        'new_password2' =>  'require|confirm:new_password1'
    ];
    protected $message = [
        'user_id.require' => '用户ID不能为空',
        'user_id.number' => '用户ID必须是数字',
        'user_id.egt' => '用户ID必须大于等于0',
        'old_password.require' => '原密码不能为空',
        'new_password1.require' => '新密码不能为空',
        'new_password1.min' => '密码长度不能小于10位',
        'new_password1.passwordStrength' => '密码必须包含字母数字，长度大于10位',
        'new_password2.require' => '确认新密码不能为空',
        'new_password2.confirm' => '两次输入密码不相同'
    ];
    protected $scene = [
        'default' => ['user_id', 'new_password1', 'new_password2'],
        'my_edit' => ['old_password', 'new_password1', 'new_password2']
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
