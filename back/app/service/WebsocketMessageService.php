<?php

namespace app\service;

use think\facade\Config;
use WebSocket\Client;

class WebsocketMessageService
{
    /**
     * 发送
     * @param $userIds
     * @param $data
     * @return void
     */
    public function send($userIds, $data)
    {
        $config = Config::get('message');
        $url = 'ws://' . $config['request_ip'] . ':' . $config['port'];

        $assembleData = [
            'type' => 'send',
            'user_ids' => $userIds,
            'data' => $data
        ];
        $encodeAssembleData = json_encode($assembleData);
        $client = new Client($url);
        $client->text($encodeAssembleData);
        $client->close();
    }
}