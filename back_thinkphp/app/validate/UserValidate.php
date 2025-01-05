<?php

namespace app\validate;

use think\Validate;

class UserValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'account'  =>  'require',
        'password' =>  'require|min:10|complexPassword',
        'name' =>  'require',
        'phone' =>  'require|mobile',
        'department_id'=>'require|number',
        'role_ids'=>'array',
        'status_id' =>  'require',
        'avatar_base64_content'=>'require',
        'password1' =>  'require|min:10|complexPassword',
        'password2' =>  'require|confirm:password1'
    ];
    protected $message = [
        'id.require' => 'id参数错误',
        'id.number' => 'id必须是数字',
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空',
        'password.min' => '密码长度不能小于10位',
        'password.complexPassword' => '密码必须包含大小写字母、数字和特殊符号',
        'name.require' => '姓名不能为空',
        'phone.require' => '手机号码不能为空',
        'phone.mobile' => '手机号码无效',
        'department_id.require' => '所属部门不能为空',
        'department_id.number' => '所属部门必须是数字',
        'role_ids.array' => '角色必须是数组',
        'status_id.require' => '请选择状态',
        'avatar_base64_content.require' => '头像内容不能为空',
        'password1.require' => '新密码不能为空',
        'password1.min' => '密码长度不能小于10位',
        'password1.complexPassword' => '密码必须包含大小写字母、数字和特殊符号',
        'password2.require' => '确认新密码不能为空',
        'password2.confirm' => '两次输入密码不相同'
    ];
    protected $scene = [
        'add' => ['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id'],
        'edit' => ['id', 'name', 'phone', 'department_id', 'role_ids'],
        'edit_status' => ['id', 'status_id'],
        'my_edit_avatar' => ['avatar_base64_content'],
        'edit_avatar'=>['id', 'avatar_base64_content'],
        'offline' => ['id'],
        'edit_password' => ['id', 'password1', 'password2'],
        'my_edit_password' => ['password1', 'password2'],
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