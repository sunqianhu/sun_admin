<?php

namespace app\validate;

use think\Validate;

class User extends Validate
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
    ];
    protected $scene = [
        'desktop_add' => ['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id'],
        'desktop_edit' => ['id', 'name', 'phone', 'department_id', 'role_ids'],
        'desktop_edit_status' => ['id', 'status_id'],
        'desktop_main_edit_avatar' => ['avatar_base64_content'],
        'desktop_offline' => ['id'],
        'desktop_login'=>['account', 'password'],
        'desktop_edit_avatar'=>['avatar_base64_content'],
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