<?php

namespace app\validate;

use think\Validate;

class Dictionary extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'type' => 'require',
        'key' => 'require',
        'value' => 'require',
        'sort' => 'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'type.require' => '字典类型不能为空',
        'key.require' => '字典键不能为空',
        'value.require' => '字典值不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['type', 'key', 'value', 'sort'],
        'desktop_edit' => ['id', 'type', 'key', 'value', 'sort'],
        'desktop_delete' => ['id']
    ];
}