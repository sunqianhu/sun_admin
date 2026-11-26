<?php

namespace app\helper\message;

use Exception;
use think\facade\Config;
use WebSocket\Client;

class WebsocketHelper
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
		$config = Config::get('message');
        if(empty($config['websocket_request_ip']) || empty($config['websocket_port'])){
            throw new Exception('还没有配置websocket服务ip和端口');
        }
        $url = 'ws://' . $config['websocket_request_ip'] . ':' . $config['websocket_port'];

        $assembleData = [
            'type' => 'send',
            'key'=>md5('sun_admin_999'),
            'user_ids' => $userIds,
            'data' => $data
        ];
        $encodeAssembleData = json_encode($assembleData);
        $client = new Client($url);
        $client->text($encodeAssembleData);
        $client->close();
    }
}
