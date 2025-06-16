<?php

namespace app\validate\desktop;

use think\Validate;

class MenuValidate extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'menu_id'  =>  'number',
        'name'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'menu_id.number' => '上级菜单必须是数字',
        'name.require' => '菜单名称不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['menu_id', 'name', 'key', 'sort'],
        'edit' => ['id', 'menu_id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}