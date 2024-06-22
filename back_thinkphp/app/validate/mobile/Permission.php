<?php

namespace app\validate\mobile;

use think\Validate;

class Permission extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'module_id'  =>  'require|number',
        'type_id'  =>  'require|number',
        'name'  =>  'require',
        'key'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'module_id.require' => '上级权限不能为空',
        'module_id.number' => '上级权限必须是数字',
        'type_id.require' => '权限类型不能为空',
        'type_id.number' => '权限类型必须是数字',
        'name.require' => '权限名称不能为空',
        'key.require' => '权限key不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['type_id', 'name', 'key', 'sort'],
        'desktop_edit' => ['id', 'type_id', 'name', 'key', 'sort'],
        'desktop_delete' => ['id']
    ];
}