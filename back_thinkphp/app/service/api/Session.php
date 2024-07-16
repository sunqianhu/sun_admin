<?php

namespace app\service\api;

use app\service\Config as ConfigService;
use app\service\api\session\Jwt;
use Exception;

class Session
{
    /**
     * ip认证
     * @param $ip
     * @return true
     * @throws Exception
     */
    function ipAuth($ip){
        $configService = new ConfigService();
        $deniedIpString = $configService->getValue('denied_ip_string');
        $deniedIps = explode("\r\n", $deniedIpString);
        if(empty($deniedIps)){
            return true;
        }
        if(in_array($ip, $deniedIps)){
            throw new Exception('您的ip已被拒绝访问');
        }
        return true;
    }

    /**
     * token认证
     * @param $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    function tokenAuth($token)
    {
        $jwt = new Jwt();
        return $jwt->resolverToken($token);
    }
}