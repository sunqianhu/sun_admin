<?php

namespace app\validate\desktop;

use think\Validate;

class Route extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'route_id'  =>  'require|number',
        'name'  =>  'require',
        'key'  =>  'require',
        'path'  =>  'require',
        'component_path'  =>  'require',
        'layout'  =>  'require',
        'keep_alive'  =>  'require|number',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'route_id.require' => '上级路由不能为空',
        'route_id.number' => '上级路由必须是数字',
        'name.require' => '路由名称不能为空',
        'key.require' => '路由标识不能为空',
        'path.require' => '路由路径不能为空',
        'component_path.require' => '组件路径不能为空',
        'layout.require' => '页面布局不能为空',
        'keep_alive.require' => '保活不能为空',
        'keep_alive.number' => '保活必须是数字',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['name', 'key', 'path', 'component_path', 'layout', 'keep_alive', 'sort'],
        'desktop_edit' => ['id', 'name', 'key', 'path', 'component_path', 'layout', 'keep_alive', 'sort'],
        'desktop_delete' => ['id']
    ];
}