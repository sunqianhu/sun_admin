<?php

namespace app\validate;

use think\Validate;

class PermissionValidate extends Validate
{
    protected $rule = [
        'id' => 'require|integer|gt:0',
        'permission_id' => 'integer|egt:0',
        'name' => 'require|max:31',
        'key' => 'require|max:127',
        'sort' => 'require|integer|egt:0',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.integer' => 'id必须是整数',
        'id.gt' => 'id参数错误',
        'permission_id.integer' => '上级权限必须是整数',
        'permission_id.egt' => '上级权限参数错误',
        'name.require' => '权限名称不能为空',
        'name.max' => '权限名称不能超过31个字符',
        'key.require' => '权限标识不能为空',
        'key.max' => '权限标识不能超过127个字符',
        'sort.require' => '排序不能为空',
        'sort.integer' => '排序必须是整数',
        'sort.egt' => '排序不能小于0',
    ];
    protected $scene = [
        'add' => ['permission_id', 'name', 'key', 'sort'],
        'edit' => ['id', 'permission_id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}
