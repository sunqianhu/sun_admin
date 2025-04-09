<?php

namespace app\validate;

use think\Validate;

class UserValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'account'  =>  'require',
        'password' =>  'require|min:10|passwordStrength',
        'name' =>  'require',
        'phone' =>  'require|mobile',
        'department_id'=>'require|number',
        'status' =>  'require'
    ];
    protected $message = [
        'id.require' => 'id参数错误',
        'id.number' => 'id必须是数字',
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空',
        'password.min' => '密码长度不能小于10位',
        'password.passwordStrength' => '密码必须包含大小写字母、数字和特殊符号',
        'name.require' => '姓名不能为空',
        'phone.require' => '手机号码不能为空',
        'phone.mobile' => '手机号码无效',
        'department_id.require' => '所属部门不能为空',
        'department_id.number' => '所属部门必须是数字',
        'status.require' => '请选择状态',
    ];
    protected $scene = [
        'add' => ['account', 'password', 'name', 'phone', 'department_id', 'status'],
        'edit' => ['id', 'name', 'phone', 'department_id'],
        'edit_status' => ['id', 'status'],
        'offline' => ['id']
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