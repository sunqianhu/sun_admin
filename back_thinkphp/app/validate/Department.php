<?php

namespace app\validate;

use think\Validate;

class Department extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'department_id'  =>  'number|different:id',
        'type_id'  =>  'require|number',
        'name'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'department_id.number' => '所属部门必须是数字',
        'department_id.different' => '所属部门不能和此部门一样',
        'type_id.require' => '部门类型不能为空',
        'type_id.number' => '部门类型必须是数字',
        'name.require' => '部门名称不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'desktop_add' => ['department_id', 'type_id', 'name', 'sort'],
        'desktop_edit' => ['id', 'department_id', 'type_id', 'name', 'sort'],
        'desktop_delete' => ['id']
    ];
}