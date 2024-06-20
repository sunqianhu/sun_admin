<?php

namespace app\validate;

use think\Validate;

class Config extends Validate
{
    protected $rule = [
        'version'  =>  'require',
    ];
    protected $message = [
        'version.require' => '版本号不能为空',
    ];
}