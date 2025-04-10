<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\model\ConfigModel;
use app\service\CrudService;
use app\validate\ConfigValidate;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $configCrudService = new CrudService(ConfigModel::class);
        $config = $configCrudService->find(1);
        return $this->success('获取成功', $config);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['denied_ip_string'=>'']);

        //验证
        try {
            validate(ConfigValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $configCrudService = new CrudService(ConfigModel::class);
        $configCrudService->upsert('id', 1, $post);

        return $this->success('保存成功');
    }
}