<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
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
        $configModel = ConfigModel::find(1);
        if(empty($configModel)){
            return $this->getErrorResponse('没有找到配置记录');
        }

        $config = $configModel->toArray();
        return $this->getSuccessResonse('获取成功', $config);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['system_name'=>'', 'denied_ip_string'=>'', 'frame_version'=>'', 'version'=>'']);

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

        return $this->getSuccessResonse('保存成功');
    }
}