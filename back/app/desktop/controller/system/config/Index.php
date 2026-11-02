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
        $configModel = ConfigModel::field('id,system_name,denied_ips_string,version')->find(1);
        if(empty($configModel)){
            return $this->getErrorResponse('没有找到配置记录');
        }

        $config = $configModel->toArray();
        return $this->getSuccessResponse('获取成功', $config);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['system_name'=>'', 'denied_ips_string'=>'', 'version'=>'']);

        $post['id'] = 1;
        try {
            validate(ConfigValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $configModel = ConfigModel::find($post['id']);
        if(empty($configModel)){
            return $this->getErrorResponse('没有找到配置记录');
        }
        $configModel->save($post);

        $configHelper = new ConfigHelper();
        $configHelper->clearCache();

        return $this->getSuccessResponse('保存成功');
    }
}
