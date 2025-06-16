<?php

namespace app\validate;

use think\Validate;

class IdValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number|egt:0'
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'id.egt' => 'id必须大于等于0'
    ];
}