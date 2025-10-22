<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\RouteModel;
use app\validate\desktop\RouteValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
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

        $routeModel = RouteModel::field('*')->find($id);
        if (empty($routeModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $route = $routeModel->toArray();

        return $this->getSuccessResponse('获取成功', $route);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name'=>'', 'key'=>'', 'path'=>'', 'component_path'=>'', 'layout'=>'', 'keep_alive'=>'', 'sort']);

        try {
            validate(RouteValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $routeModel = RouteModel::find($post['id']);
        if(empty($routeModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $routeModel->save($post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}