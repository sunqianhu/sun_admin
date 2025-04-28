<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\model\ConfigModel;
use app\service\CrudService;
use app\validate\ConfigValidate;
use think\exception\ValidateException;
use think\Response;

class Index extends Base
{
    /**
     * 初始化
     * @return Response
     */
    public function init()
    {
        $configCrudService = new CrudService(ConfigModel::class);
        $config = $configCrudService->selectRow(1);
        return $this->getSuccessResonse('获取成功', $config);
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
            return $this->getErrorResponse($exception->getError());
        }

        $configCrudService = new CrudService(ConfigModel::class);
        $configCrudService->upsertByField('id', 1, $post);

        return $this->getSuccessResonse('保存成功');
    }
}