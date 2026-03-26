<?php

namespace app\validate\role;

use think\Validate;

class RoleDataScopeValidate extends Validate
{
    protected $rule = [
        'role_id' => 'require|number',
        'data_scopes' => 'array'
    ];
    protected $message = [
        'role_id.require' => 'role_ID不能为空',
        'role_id.number' => 'role_ID必须是数字',
        'data_scopes.array' => '数据权限必须是数组'
    ];
    protected $scene = [
        'edit_init' => ['role_id'],
        'edit_save' => ['role_id', 'data_scopes']
    ];
}