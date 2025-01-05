<?php

namespace app\validate\statistic;

use think\Validate;

class DepartmentValidate extends Validate
{
    protected $rule = [
        'add_times'=>'require|array|arrayItemNumber'
    ];
    protected $message = [
        'add_times.require' => '订单时间不能为空',
        'add_times.array' => '订单时间必须是个数组',
        'add_times.arrayItemNumber' => '订单时间项必须是数字'
    ];
    protected $scene = [
        'desktop_init'=>['add_times'],
        'desktop_export_excel'=>['add_times']
    ];

    /**
     * 数组项必须是数字
     * @param $value
     * @param $rule
     * @param $data
     * @return void
     */
    protected function arrayItemNumber($arr, $rule, $data=[])
    {
        foreach($arr as $item){
            if(!is_numeric($item)){
                return '数组项必须是数字';
            }
        }
        return true;
    }
}