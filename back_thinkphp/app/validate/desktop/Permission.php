<?php

namespace app\validate\desktop;

use think\Validate;

class Permission extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'permission_id'  =>  'number|different:id',
        'name'  =>  'require',
        'key'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'permission_id.number' => '上级权限必须是数字',
        'permission_id.different'=>'上级权限不能和本权限一样',
        'name.require' => '权限名称不能为空',
        'key.require' => '权限key不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['permission_id', 'name', 'key', 'sort'],
        'desktop_edit' => ['id', 'permission_id', 'name', 'key', 'sort'],
        'desktop_delete' => ['id']
    ];
}