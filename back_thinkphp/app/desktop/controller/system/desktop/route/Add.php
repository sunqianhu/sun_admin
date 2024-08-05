<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\service\desktop\Route as RouteService;
use app\service\Dictionary as DictionaryService;
use app\validate\desktop\Route as RouteValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $dictionaryService = new DictionaryService();
        $containers = $dictionaryService->getList('desktop_route_container');

        $data = [
            'containers' => $containers
        ];
        return $this->success('获取成功', $data);
    }
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name'=>'', 'key'=>'', 'path'=>'', 'component_path'=>'', 'container'=>'', 'keep_alive'=>'', 'sort']);

        //验证
        try {
            validate(RouteValidate::class)->scene('desktop_add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $routeService = new RouteService();
        try{
            $routeService->add($post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}