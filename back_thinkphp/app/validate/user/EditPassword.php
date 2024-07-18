<?php

namespace app\validate\user;

use think\Validate;

class EditPassword extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'password1' =>  'require|min:10|complexPassword',
        'password2' =>  'require|confirm:password1'
    ];
    protected $message = [
        'id.require' => 'id参数错误',
        'id.number' => 'id必须是数字',
        'password1.require' => '新密码不能为空',
        'password1.min' => '密码长度不能小于10位',
        'password1.complexPassword' => '密码必须包含大小写字母、数字和特殊符号',
        'password2.require' => '确认新密码不能为空',
        'password2.confirm' => '两次输入密码不相同'
    ];
    protected $scene = [
        'desktop_edit_password' => ['id', 'password1', 'password2'],
        'desktop_main_edit_password' => ['password1', 'password2'],
    ];

    /**
     * 复杂的密码
     * @param $value
     * @param $rule
     * @param $data
     * @return bool
     */
    protected function complexPassword($value, $rule, $data)
    {
        $pattern = '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$/';
        if (preg_match($pattern, $value)) {
            return true;
        }
        return false;
    }
}