<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\DictionaryService;
use app\validate\DictionaryValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['type', 'key', 'value', 'sort']);

        //验证
        try {
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $dictionary = new DictionaryService();
            $dictionary->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}