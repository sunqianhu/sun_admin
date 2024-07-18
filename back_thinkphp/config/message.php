<?php
/**
 * websocket 系统消息配置
 */
return [
    'ip' => env('MESSAGE_IP', '127.0.0.1'), //监听ip
    'port' => env('MESSAGE_PORT', 9101) //端口
];
