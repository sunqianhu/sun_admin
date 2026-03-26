<?php

namespace app\desktop\controller\system\data_scope;

use app\desktop\controller\Base;
use app\model\DataScopeModel;
use app\validate\DataScopeValidate;
use app\validate\IdValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class Edit extends Base
{
    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        $dataScopeModel = DataScopeModel::field('id,name,key,sort')->find($id);
        if (empty($dataScopeModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $dataScope = $dataScopeModel->toArray();

        return $this->getSuccessResponse('获取成功', $dataScope);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name', 'key', 'sort']);

        try {
            validate(DataScopeValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $dataScopeModel = DataScopeModel::find($post['id']);
        if(empty($dataScopeModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $dataScopeModel->save($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}