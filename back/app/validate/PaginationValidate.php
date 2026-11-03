<?php

namespace app\validate;

use think\Validate;

class PaginationValidate extends Validate
{
    protected $rule = [
        'size' => 'require|integer|between:1,300',
        'page' => 'require|integer|gt:0',
    ];
    protected $message = [
        'size.require' => '每页条数不能为空',
        'size.integer' => '每页条数必须是整数',
        'size.between' => '每页条数必须在1至300之间',
        'page.require' => '页码不能为空',
        'page.integer' => '页码必须是整数',
        'page.gt' => '页码必须大于0',
    ];
}
