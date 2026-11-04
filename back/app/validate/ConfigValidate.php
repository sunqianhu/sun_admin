<?php

namespace app\validate;

use think\Validate;

class ConfigValidate extends Validate
{
    protected $rule = [
        'id'=>'require|number',
        'system_name'=>'require',
        'system_description'=>'max:1000',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'system_name.require' => '系统名称不能为空',
        'system_description.max' => '系统简介不能超过1000个字符',
    ];

    protected $scene = [
        'edit' => ['id', 'system_name', 'system_description'],
    ];
}
