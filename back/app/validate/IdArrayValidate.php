<?php

namespace app\validate;

use think\exception\ValidateException;

class IdArrayValidate
{
    /**
     * 验证
     * @param $ids
     * @param $fieldName
     * @return void
     */
    static public function check($ids, $fieldName)
    {
        if(!is_array($ids)){
            throw new ValidateException($fieldName.'必须是个数组');
        }
        foreach ($ids as $id){
            try {
                validate(IdValidate::class)->check(['id'=>$id]);
            }catch (ValidateException $exception){
                throw new ValidateException($fieldName.'中有不合法的id');
            }
        }
    }
}