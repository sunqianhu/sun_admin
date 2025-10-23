<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\helper\ConfigHelper;
use Exception;
use think\Response;

class SidebarLayout extends Base
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
        $systemName = $configHelper->getValue('system_name');
        $data = [
            'system_name' => $systemName
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }
}