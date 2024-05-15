<?php

namespace app\desktop\validate\system\desktop;

use think\Validate;

class Module extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'module_id'  =>  'require|number',
        'type_id'  =>  'require|number',
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
        'type_id.require' => '模块类型不能为空',
        'type_id.number' => '模块类型必须是数字',
        'name.require' => '模块名称不能为空',
        'key.require' => '模块key不能为空',
        'keep_alive.require' => '保活不能为空',
        'keep_alive.number' => '保活必须是数字',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type_id', 'name', 'key', 'keep_alive', 'sort'],
        'edit' => ['id', 'type_id', 'name', 'key', 'keep_alive', 'sort'],
        'delete' => ['id']
    ];
}