<?php

namespace app\validate;

use think\Validate;

class TimeRangeValidate extends Validate
{
    protected $rule = [
        'start_time'  =>  'require|number',
        'end_time'  =>  'require|number|gt:start_time'
    ];
    protected $message = [
        'start_time.require' => '开始时间不能为空',
        'start_time.number' => '开始时间必须是数字',
        'end_time.require' => '结束时间不能为空',
        'end_time.number' => '结束时间必须是数字',
        'end_time.gt' => '结束时间必须大于开始时间'
    ];
}