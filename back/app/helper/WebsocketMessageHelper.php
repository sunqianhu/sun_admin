<?php

namespace app\helper;

use Exception;
use think\facade\Config;
use WebSocket\Client;

class WebsocketMessageHelper
{
    /**
     * 发送
     * @param $userIds
     * @param $data
     * @return void
     * @throws Exception
     */
    public function send($userIds, $data)
    {
        if(empty($config['request_ip']) || empty($config['port'])){
            throw new Exception('还没有配置websocket服务ip和端口');
        }
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