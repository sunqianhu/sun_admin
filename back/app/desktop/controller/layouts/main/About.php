<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\helper\ConfigHelper;
use Exception;
use think\Response;

class About extends Base
{
    public bool $isApiAuth = false;

    /**
     * 初始化
     * @return Response
     * @throws Exception
     */
    public function init()
    {
        $configHelper = new ConfigHelper();
        $data = [
            'system_name' => $configHelper->getValue('system_name'),
            'version' => config('app.version')
        ];

        return $this->getSuccessResponse('获取成功', $data);
    }
}
