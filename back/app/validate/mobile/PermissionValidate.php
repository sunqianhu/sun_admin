<?php

namespace app\validate\mobile;

use think\Validate;

class PermissionValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'permission_id'  =>  'number',
        'name'  =>  'require',
        'key'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'permission_id.number' => '上级权限必须是数字',
        'name.require' => '权限名称不能为空',
        'key.require' => '权限key不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['permission_id', 'name', 'key', 'sort'],
        'edit' => ['id', 'permission_id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}