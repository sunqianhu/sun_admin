<?php

namespace app\validate;

use think\Validate;

class DictionaryValidate extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'type' => 'require'
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'type.require' => '字典类型不能为空'
    ];
    protected $scene = [
        'add' => ['type'],
        'edit' => ['id', 'type'],
        'delete' => ['id']
    ];
}