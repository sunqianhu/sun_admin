<?php
/**
 * websocket 右下角消息配置
 */
return [
    'listen_ip' => env('MESSAGE_LISTEN_IP', '0.0.0.0'), //监听ip
    'request_ip' => env('MESSAGE_REQUEST_IP', '127.0.0.1'), //请求ip
    'port' => env('MESSAGE_PORT', 7001) //端口
];
