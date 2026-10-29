<?php

namespace app\helper;

use app\model\ConfigModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Cache;

class IpAuthHelper
{
    /**
     * ip认证
     * @param $ip
     * @return bool
     * @throws Exception
     */
    function ipAuth($ip)
    {
        $configHelper = new ConfigHelper();
        $deniedIps = $configHelper->getDeniedIps();
        if (empty($deniedIps)) {
            return true;
        }
        if (in_array($ip, $deniedIps)) {
            throw new Exception('您的ip已被拒绝访问');
        }
        return true;
    }
}
