<?php

namespace app\desktop\controller\system\config;

use app\desktop\controller\Base;
use app\service\Config as ConfigService;
use app\validate\Config as ConfigValidate;
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
        $configService = new ConfigService();
        $config = [
            'version'=>$configService->getValue('version')
        ];
        $data = [
            'config' => $config
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['version']);

        //验证
        try {
            validate(ConfigValidate::class)->scene('desktop_index')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $configService = new ConfigService();
        foreach($post as $key => $value){
            $configService->setValue($key, $value);
        }

        return $this->success('保存成功');
    }
}