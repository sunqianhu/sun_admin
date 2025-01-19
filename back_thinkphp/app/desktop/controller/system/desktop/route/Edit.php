<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\RouteModel;
use app\service\desktop\RouteService;
use app\validate\desktop\RouteValidate;
use Exception;
use think\exception\ValidateException;

class edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $route = RouteModel::field('*')->find($id);
        if (empty($route)) {
            return $this->error('没有找到记录');
        }
        $routeArray = $route->toArray();

        return $this->success('获取成功', $routeArray);
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
            return $this->error($exception->getError());
        }

        $route = new RouteService();
        try{
            $route->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}