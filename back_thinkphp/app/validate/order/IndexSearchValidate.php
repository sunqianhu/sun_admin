<?php

namespace app\validate\order;

use think\Validate;

class IndexSearchValidate extends Validate
{
    protected $rule = [
        'add_times' => 'require|array'
    ];
    protected $message = [
        'add_times.require' => '统计时间不能为空',
        'add_times.array' => '统计时间必须是数组'
    ];
    protected $scene = [
        'trend' => ['add_times'],
        'exp' => ['add_times']
    ];
}