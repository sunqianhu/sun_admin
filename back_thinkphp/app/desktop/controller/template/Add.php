<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\model\DictionaryModel;
use app\service\CrudService;
use app\validate\DictionaryValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     * @return \think\Response
     */
    public function save()
    {
        $post = $this->request->post(['type', 'key', 'value', 'sort']);

        try {
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $dictionaryCrudService = new CrudService(DictionaryModel::class);
        try{
            $dictionaryCrudService->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}