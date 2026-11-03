<?php

namespace app\validate\user;

use think\Validate;

class UserSelectValidate extends Validate
{
    protected $rule = [
        'user_id'  =>  'require|number|egt:0'
    ];
    protected $message = [
        'user_id.require' => 'id不能为空',
        'user_id.number' => 'id必须是数字',
        'user_id.egt' => 'id必须大于等于0'
    ];
}