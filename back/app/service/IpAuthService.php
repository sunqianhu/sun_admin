<?php

namespace app\service;

use app\model\ConfigModel;
use Exception;

class IpAuthService
{

    /**
     * ip认证
     * @param $ip
     * @return bool
     * @throws Exception
     */
    function ipAuth($ip)
    {
        $configModel = ConfigModel::field('denied_ip_string')->find(1);
        if (empty($configModel)) {
            throw new Exception('没有找到系统配置记录');
        }
        $deniedIpString = $configModel->denied_ip_string;
        $deniedIps = explode("\r\n", $deniedIpString);
        $deniedIps = array_filter($deniedIps);
        if (empty($deniedIps)) {
            return true;
        }
        if (in_array($ip, $deniedIps)) {
            throw new Exception('您的ip已被拒绝访问');
        }
        return true;
    }
}