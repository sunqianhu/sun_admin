<?php
namespace app;

// 应用请求对象类
class Request extends \think\Request
{
    //当前请求的认证用户信息，由Base控制器设置
    public int $userId = 0;
    public int $departmentId = 0;

    //保留异常原因，供操作日志记录
    public ?string $exceptionMessage = null;
}
