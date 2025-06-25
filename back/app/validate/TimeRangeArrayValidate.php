<?php

namespace app\validate;

use think\exception\ValidateException;

class TimeRangeArrayValidate
{
    /**
     * 验证
     * @param $times
     * @param string $fieldName
     * @return true
     */
    static public function check($times, $fieldName = '时间范围')
    {
        if(!is_array($times)){
            throw new ValidateException($fieldName.'必须是个数组');
        }
		if(count($times) != 2){
			throw new ValidateException($fieldName.'格式错误');
		}
		if(!is_numeric($times[0])){
			throw new ValidateException($fieldName.'开始时间格式错误');
		}
		if(!is_numeric($times[1])){
			throw new ValidateException($fieldName.'结束时间格式错误');
		}
		return true;
    }
}