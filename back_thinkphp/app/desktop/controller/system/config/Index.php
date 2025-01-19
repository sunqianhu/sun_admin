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
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $config = new ConfigService();
        $configForm = [
            'denied_ip_string'=>$config->getValue('denied_ip_string')
        ];
        return $this->success('获取成功', $configForm);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['denied_ip_string'=>'']);

        //验证
        try {
            validate(ConfigFormValidate::class)->scene('save')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $config = new ConfigService();
        foreach($post as $key => $value){
            $config->setValue($key, $value);
        }

        return $this->success('保存成功');
    }
}