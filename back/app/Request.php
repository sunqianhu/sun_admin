<?php
namespace app;

// 应用请求对象类
class Request extends \think\Request
{
    public int $sessionId = 0;
    public int $userId = 0;
    public int $departmentId = 0;
}
