<?php

namespace app\validate;

use think\Validate;

class DataScopeValidate extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'name' => 'require',
        'key' => 'require',
        'sort' => 'require|number',
    ];
    protected $message = [
        'id.require' => 'ID不能为空',
        'id.number' => 'ID必须是数字',
        'name.require' => '名称不能为空',
        'key.require' => '标识不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['name', 'key', 'sort'],
        'edit' => ['id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}