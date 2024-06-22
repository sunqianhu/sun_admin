<?php

namespace app\validate\desktop;

use think\Validate;

class Route extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'module_id'  =>  'require|number',
        'name'  =>  'require',
        'key'  =>  'require',
        'keep_alive'  =>  'require|number',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'module_id.require' => '上级模块不能为空',
        'module_id.number' => '上级模块必须是数字',
        'name.require' => '模块名称不能为空',
        'key.require' => '模块key不能为空',
        'keep_alive.require' => '保活不能为空',
        'keep_alive.number' => '保活必须是数字',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['name', 'key', 'keep_alive', 'sort'],
        'desktop_edit' => ['id', 'name', 'key', 'keep_alive', 'sort'],
        'desktop_delete' => ['id']
    ];
}