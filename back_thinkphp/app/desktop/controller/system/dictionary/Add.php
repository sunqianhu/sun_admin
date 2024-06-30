<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\Dictionary as DictionaryService;
use app\validate\Dictionary as DictionaryValidate;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存添加
     */
    public function save()
    {
        $post = $this->request->post(['type', 'key', 'value', 'sort']);

        //验证
        try {
            validate(DictionaryValidate::class)->scene('desktop_add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $dictionaryService = new DictionaryService();
            $dictionaryService->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}