<?php

namespace app\desktop\controller;

use app\helper\ConfigHelper;
use Exception;
use think\response\Redirect;

class Favicon extends Base
{
    public bool $isTokenAuth = false;

    /**
     * 浏览器图标
     * @return Redirect
     * @throws Exception
     */
    public function index()
    {
        $configHelper = new ConfigHelper();
        return redirect($configHelper->getValue('system_favicon_url'))
            ->header(['Cache-Control' => 'no-cache, no-store, must-revalidate']);
    }
}
