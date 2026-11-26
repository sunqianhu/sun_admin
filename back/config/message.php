<?php
/**
 * websocket 右下角消息配置
 */
return [
    'websocket_listen_ip' => env('MESSAGE_WEBSOCKET_LISTEN_IP', '0.0.0.0'), //监听ip
    'websocket_request_ip' => env('MESSAGE_WEBSOCKET_REQUEST_IP', '127.0.0.1'), //请求ip
    'websocket_port' => env('MESSAGE_WEBSOCKET_PORT', 7001) //端口
];
