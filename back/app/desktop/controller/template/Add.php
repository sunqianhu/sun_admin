<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\model\DictionaryModel;
use Sunqianhu\Helper\thinkphp\Crud;
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
        $post = $this->request->post(['type', 'key', 'value', 'sort']);

        try {
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $dictionaryCrud = new Crud(DictionaryModel::class);
        try{
            $dictionaryCrud->insert($post);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}