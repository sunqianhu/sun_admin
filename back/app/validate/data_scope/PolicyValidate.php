<?php

namespace app\validate\data_scope;

use think\Validate;

class PolicyValidate extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'data_scope_id' => 'require|number',
        'name' => 'require',
        'type' => 'require',
        'sort' => 'require|number',
    ];
    protected $message = [
        'id.require' => 'ID不能为空',
        'id.number' => 'ID必须是数字',
        'data_scope_id.require' => 'data_scope_ID不能为空',
        'data_scope_id.number' => 'data_scope_ID必须是数字',
        'name.require' => '名称不能为空',
        'type.require' => '类型不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['data_scope_id','name', 'type', 'sort'],
        'edit' => ['id', 'data_scope_id', 'name', 'type', 'sort'],
        'delete' => ['id']
    ];
}