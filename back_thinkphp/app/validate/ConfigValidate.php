<?php

namespace app\validate;

use think\Validate;

class ConfigValidate extends Validate
{
    protected $rule = [
    ];
    protected $message = [
    ];

    protected $scene = [
        'save' => []
    ];
}