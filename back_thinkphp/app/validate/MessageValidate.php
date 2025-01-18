<?php

namespace app\validate;

use think\Validate;

class MessageValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number'
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是个数字'
    ];
    protected $scene = [
        'set_read' => ['id']
    ];
}