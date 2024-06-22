<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Dictionary as DictionaryModel;
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
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $dictionaryModel = new DictionaryModel();
        $dictionaryModel->save($post);

        return $this->success('添加成功');
    }
}