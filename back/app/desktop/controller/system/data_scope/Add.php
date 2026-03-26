<?php

namespace app\desktop\controller\system\data_scope;

use app\desktop\controller\Base;
use app\model\DataScopeModel;
use app\validate\DataScopeValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name', 'key', 'sort']);

        try {
            validate(DataScopeValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try{
            $dataScopeModel = new DataScopeModel();
            $dataScopeModel->save($post);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}