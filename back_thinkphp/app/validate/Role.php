<?php

namespace app\validate;

use think\Validate;

class Role extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'name' => 'require'
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'name.require' => '字典名称不能为空'
    ];
    protected $scene = [
        'desktop_add' => ['name'],
        'desktop_edit' => ['id', 'name'],
        'desktop_delete' => ['id']
    ];
}