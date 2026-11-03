<?php

namespace app\validate\operation_log;

use think\Validate;

class TimeRangeDeleteValidate extends Validate
{
    protected $rule = [
        'start_time' => 'require|integer',
        'end_time' => 'require|integer|egt:start_time',
    ];
    protected $message = [
        'start_time.require' => '请选择开始时间',
        'start_time.integer' => '开始时间必须是整数时间戳',
        'end_time.require' => '请选择结束时间',
        'end_time.integer' => '结束时间必须是整数时间戳',
        'end_time.egt' => '结束时间不能早于开始时间',
    ];
}
