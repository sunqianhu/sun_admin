<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\service\ConfigService;
use app\validate\ConfigFormValidate;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $configService = new ConfigService();
        $configForm = [
            'denied_ip_string'=>$configService->getValue('denied_ip_string')
        ];
        return $this->success('获取成功', $configForm);
    }

    /**
     * 保存
     */
    public function save()
    {
        $keys = ['denied_ip_string'];
        $post = $this->request->post(['denied_ip_string'=>'']);

        //验证
        try {
            validate(ConfigFormValidate::class)->scene('save')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $config = new ConfigService();
        foreach($keys as $key){
            $config->setValue($key, $post[$key]);
        }

        return $this->success('保存成功');
    }
}