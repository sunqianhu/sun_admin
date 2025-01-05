<?php

namespace app\desktop\controller\system\desktop\route;

use app\desktop\controller\Base;
use app\service\desktop\Route;
use app\service\Dictionary;
use app\validate\desktop\RouteValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $dictionary = new Dictionary();
        $layouts = $dictionary->getList('desktop_route_layout');

        $data = [
            'layouts' => $layouts
        ];
        return $this->success('获取成功', $data);
    }
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

        $route = new Route();
        try{
            $route->add($post);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}