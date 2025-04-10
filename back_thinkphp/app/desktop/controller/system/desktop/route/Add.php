<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\RouteModel;
use app\service\CrudService;
use app\validate\desktop\RouteValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name'=>'', 'key'=>'', 'path'=>'', 'component_path'=>'', 'layout'=>'', 'keep_alive'=>'', 'sort']);

        //验证
        try {
            validate(RouteValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $routeCrudService = new CrudService(RouteModel::class);
        try{
            $routeCrudService->add($post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}