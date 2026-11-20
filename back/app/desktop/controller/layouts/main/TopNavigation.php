<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\helper\ConfigHelper;
use Exception;
use think\Response;

class TopNavigation extends Base
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
        $config = $configHelper->get();
        $data = [
            'system_name' => $config['system_name'],
            'system_logo_url' => $config['system_logo_url'],
            'version' => config('app.version')
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }
}
