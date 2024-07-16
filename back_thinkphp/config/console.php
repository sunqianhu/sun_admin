<?php
// +----------------------------------------------------------------------
// | 控制台配置
// +----------------------------------------------------------------------
return [
    // 指令定义
    'commands' => [
        'message' => 'app\command\Message',
        'generate_api_token'=>'app\command\GenerateApiToken',
        'test' => 'app\command\Test'
    ],
];
