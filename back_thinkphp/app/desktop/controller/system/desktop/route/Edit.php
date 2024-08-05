<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\model\desktop\Route as RouteModel;
use app\service\desktop\Route as RouteService;
use app\service\Dictionary as DictionaryService;
use app\validate\desktop\Route as RouteValidate;
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

        $routeModel = RouteModel::field('*')->find($id);
        if (empty($routeModel)) {
            return $this->error('没有找到记录');
        }
        $route = $routeModel->toArray();

        $dictionaryService = new DictionaryService();
        $containers = $dictionaryService->getList('desktop_route_container');

        $data = [
            'route' => $route,
            'containers' => $containers
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name'=>'', 'key'=>'', 'path'=>'', 'component_path'=>'', 'container'=>'', 'keep_alive'=>'', 'sort']);

        //验证
        try {
            validate(RouteValidate::class)->scene('desktop_edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $routeService = new RouteService();
        try{
            $routeService->edit($post['id'], $post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}