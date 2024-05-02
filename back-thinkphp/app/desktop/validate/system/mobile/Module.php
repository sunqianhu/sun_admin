<?php

namespace app\desktop\validate\system\mobile;

use think\Validate;

class Module extends Validate
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
        'module_id.require' => '上级模块不能为空',
        'module_id.number' => '上级模块必须是数字',
        'type_id.require' => '模块类型不能为空',
        'type_id.number' => '模块类型必须是数字',
        'name.require' => '模块名称不能为空',
        'key.require' => '模块key不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type_id', 'name', 'key', 'sort'],
        'edit' => ['id', 'type_id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}