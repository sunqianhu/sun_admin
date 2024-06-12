<?php
/**
 * websocket配置
 */
return [
    'server_ip' => env('message.server_ip', '0.0.0.0'), // 服务器端监听ip
    'client_ip' => env('message.client_ip', '127.0.0.1'), // 客户端访问ip
    'port' => env('message.port', 9001) // 端口
];
