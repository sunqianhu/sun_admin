<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\RouteModel;
use app\service\CrudService;
use app\validate\desktop\RouteValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class edit extends Base
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

        return $this->getSuccessResonse('获取成功', $route);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name'=>'', 'key'=>'', 'path'=>'', 'component_path'=>'', 'layout'=>'', 'keep_alive'=>'', 'sort']);

        //验证
        try {
            validate(RouteValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $routeCrudService = new CrudService(RouteModel::class);
        try{
            $routeCrudService->update($post['id'], $post);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('修改成功');
    }
}