<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\model\ConfigModel;
use Sunqianhu\Helper\thinkphp\Crud;
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
        $configCrud = new Crud(ConfigModel::class);
        $config = $configCrud->selectRow(1);
        return $this->getSuccessResonse('获取成功', $config);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['denied_ip_string'=>'', 'frame_version'=>'', 'version'=>'']);
        $post['id'] = 1;

        //验证
        try {
            validate(ConfigValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $configCrud = new Crud(ConfigModel::class);
        $configCrud->upsert($post['id'], $post);

        return $this->getSuccessResonse('保存成功');
    }
}