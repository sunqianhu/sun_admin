<?php

namespace app\desktop\controller\layouts;

use app\desktop\controller\Base;
use app\service\ConfigService;
use Exception;
use think\Response;

class Main extends Base
{
    public bool $isApiAuth = false;

    /**
     * 初始化
     * @return Response
     * @throws Exception
     */
    public function init()
    {
        $configService = new ConfigService();
        $systemName = $configService->getValue('system_name');
        $data = [
            'system_name' => $systemName
        ];
        return $this->getSuccessResonse('获取成功', $data);
    }
}