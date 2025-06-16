<?php

namespace app\validate;

use think\Validate;

class ConfigValidate extends Validate
{
    protected $rule = [
        'id'=>'require|number',
        'frame_version'=>'require',
        'version'=>'require'
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'frame_version.require' => '框架版本不能为空',
        'version.require' => '系统版本不能为空',
    ];

    protected $scene = [
        'edit' => ['id', 'frame_version', 'version'],
    ];
}