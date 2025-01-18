<?php

namespace app\service;

use app\model\MessageModel;
use Sunqianhu\Helper\StringHandler;
use think\facade\Config;
use think\facade\Db;
use think\facade\Queue;
use WebSocket\Client;
use Exception;

class Message extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(MessageModel::class);
    }

    /**
     * 设置用户单条已读
     * @param $userId
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function setUserItemRead($userId, $id)
    {
        $message = MessageModel::where('user_id', $userId)
            ->where('id', $id)
            ->find();
        if (empty($message)) {
            throw new Exception('没有找到记录');
        }
        $message->save(['is_read' => 1, 'read_time' => time()]);
    }

    /**
     * 发送多条
     * @param $userIds
     * @param $title
     * @param $content
     * @param $url
     * @return void
     */
    public function sends($userIds, $title, $content = '', $url = '')
    {
        if (empty($userIds) || $title === '') {
            throw new Exception('消息接收用户和消息标题不能为空');
        }

        $messageIds = [];
        foreach ($userIds as $userId) {
            $messageIds[] = $this->send($userId, $title, $content, $url);
        }

        return $messageIds;
    }

    /**
     * 发送一条
     * @param $userId
     * @param $title
     * @param $content
     * @param $url
     * @return int
     * @throws Exception
     */
    public function send($userId, $title, $content = '', $url = '')
    {
        if (empty($userId) || $title === '') {
            throw new Exception('消息接收用户和消息标题不能为空');
        }

        Db::startTrans();
        try {
            $time = time();
            $data = [
                'user_id' => $userId,
                'title' => $title,
                'content' => $content,
                'url' => $url,
                'add_time' => $time
            ];
            $messageId = $this->add($data);

            $config = Config::get('message');
            $data = [
                'type' => 'send',
                'user_ids' => [$userId],
                'data' => [
                    'type' => 'new',
                    'id' => $messageId,
                    'title' => $title,
                    'content' => $content,
                    'url' => $url,
                    'add_time' => $time
                ]
            ];
            $encodeData = json_encode($data);
            $url = 'ws://' . $config['request_ip'] . ':' . $config['port'];
            $client = new Client($url);
            $client->text($encodeData);
            $client->close();
            Db::commit();
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
            Db::rollback();
        }
        return $messageId;
    }

    /**
     * 通过队列发送消息
     * @param $userIds
     * @param $title
     * @param $content
     * @param $url
     * @return void
     */
    public function queueSends($userIds, $title, $content = '', $url = '')
    {
        if (empty($userIds) || $title === '') {
            throw new Exception('消息接收用户和消息标题不能为空');
        }

        $data = [
            'user_ids' => $userIds,
            'content' => $content,
            'title' => $title,
            'url' => $url
        ];
        Queue::push('app\job\MessageJob', $data, 'message');
    }
}