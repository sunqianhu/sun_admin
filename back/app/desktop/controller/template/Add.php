<?php

namespace app\desktop\controller\dictionary;

use app\desktop\controller\Base;
use app\helper\DictionaryHelper;
use app\validate\DictionaryValidate;
use Exception;
use think\exception\ValidateException;
use think\Response;

class Add extends Base
{
    /**
     * 保存
     * @return Response
     */
    public function save()
    {
        $post = $this->request->post(['type']);

        try {
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try{
            $dictionaryHelper = new DictionaryHelper();
            $dictionaryHelper->add($post);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
