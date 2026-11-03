<?php
namespace app;

// 应用请求对象类
class Request extends \think\Request
{
    //可信代理网段
    protected $proxyServerIp = ['172.30.0.0/24'];

    //真实IP请求头
    protected $proxyServerIpHeader = ['HTTP_X_REAL_IP'];

    public int $sessionId = 0;
    public int $userId = 0;
    public int $departmentId = 0;
}
