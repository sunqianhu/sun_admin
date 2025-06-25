<?php

namespace app\validate;

use think\exception\ValidateException;

class IdArrayValidate
{
    /**
     * 验证
     * @param $ids
     * @param $fieldName
     * @return true
     */
    static public function check($ids, $fieldName)
    {
        if(!is_array($ids)){
            throw new ValidateException($fieldName.'必须是个数组');
        }
        foreach ($ids as $id){
            validate(IdValidate::class)->check(['id'=>$id]);
        }
        return true;
    }
}