<?php

namespace app\validate;

use think\Validate;

class SessionValidate extends Validate
{
    protected $rule = [
        'id' => 'require|integer|gt:0',
        'name' => 'max:63',
        'terminal' => 'require|integer|in:0,1,2',
        'user_id' => 'require|integer|gt:0',
        'expire_time' => 'require|integer|gt:0',
    ];
    protected $message = [
        'id.require' => 'ID不能为空',
        'id.integer' => 'ID必须是整数',
        'id.gt' => 'ID参数错误',
        'name.max' => '会话名称不能超过63个字符',
        'terminal.require' => '请选择终端',
        'terminal.integer' => '终端参数错误',
        'terminal.in' => '终端参数错误',
        'user_id.require' => '请选择所属用户',
        'user_id.integer' => '用户ID必须是整数',
        'user_id.gt' => '请选择所属用户',
        'expire_time.require' => '请选择过期时间',
        'expire_time.integer' => '过期时间必须是时间戳',
        'expire_time.gt' => '过期时间无效',
    ];
    protected $scene = [
        'add' => ['name', 'terminal', 'user_id', 'expire_time'],
        'renew' => ['id', 'expire_time'],
        'delete' => ['id'],
    ];
}
