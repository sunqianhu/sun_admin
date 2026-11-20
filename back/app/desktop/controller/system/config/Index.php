<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\helper\ConfigHelper;
use app\model\ConfigModel;
use app\validate\ConfigValidate;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class Index extends Base
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
        $configHelper = new ConfigHelper();
        $config = $configHelper->get();
        return $this->getSuccessResponse('获取成功', $config);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['system_name'=>'', 'system_logo'=>'', 'system_description'=>'', 'denied_ips_string'=>'']);

        try {
            $post['id'] = 1;
            validate(ConfigValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $configHelper = new ConfigHelper();
        $data = $post;
        unset($data['id']);
        $configHelper->edit($data);

        return $this->getSuccessResponse('保存成功');
    }
}
