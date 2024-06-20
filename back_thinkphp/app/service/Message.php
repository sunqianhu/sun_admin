<?php

namespace app\service;

use app\model\Message as MessageModel;
use Sunqianhu\Helper\StringHandler;
use think\facade\Config;
use think\facade\Queue;
use WebSocket\Client;
use Exception;

class Message
{
    /**
     * 发送消息
     * @param $userIds
     * @param $title
     * @param $url
     * @return void
     * @throws Exception
     */
    public function send($userIds, $title, $url = '')
    {
        if (empty($userIds)) {
            return;
        }

        $stringHandler = new StringHandler();
        if($stringHandler->length($title) > 64){
            $title = $stringHandler->sub($title, 0, 64);
        }

        //入库
        foreach ($userIds as $userId) {
            $data = [
                'user_id' => $userId,
                'title' => $title,
                'url' => $userId,
                'add_time' => time()
            ];
            $messageModel = new MessageModel();
            $messageModel->save($data);
        }

        //消息
        $config = Config::get('message');
        $data = [
            'type' => 'send',
            'user_ids' => $userIds,
            'data' => [
                'type' => 'message',
                'title' => $title,
                'url' => $url
            ]
        ];
        $encodeData = json_encode($data);
        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($encodeData);
        $client->close();
    }

    /**
     * 通过队列发送消息
     * @param $userIds
     * @param $title
     * @param $url
     * @return void
     */
    public function sendByQueue($userIds, $title, $url = ''){
        $data = [
            'user_ids'=>$userIds,
            'title'=>$title,
            'url'=>$url
        ];
        Queue::push('app\job\Message', $data, 'message');
    }
}