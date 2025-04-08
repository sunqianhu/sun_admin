<?php

namespace app\service;

use app\model\MessageModel;
use think\facade\Db;
use think\facade\Queue;
use Exception;

class MessageService extends CrudService
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
     * 发送消息
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

            $data = [
                'type' => 'message',
                'id' => $messageId,
                'title' => $title,
                'content' => $content,
                'url' => $url,
                'add_time' => $time
            ];
            $websocketMessage = new WebsocketMessageService();
            $websocketMessage->send([$userId], $data);

            Db::commit();
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
            Db::rollback();
        }
        return $messageId;
    }

    /**
     * 发送多用户消息
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
     * 通过队列发送消息列表
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
            'type' => 'message',
            'data' => [
                'type'=>'message',
                'user_ids' => $userIds,
                'title' => $title,
                'content' => $content,
                'url' => $url
            ]
        ];
        Queue::push('app\job\Message', $data, 'message');
    }

    /**
     * 得到未读数
     * @param $userId
     * @return int
     */
    public function getNoReadCount($userId)
    {
        $count = MessageModel::where('user_id', $userId)
            ->where('is_read', 0)
            ->count();
        return $count;
    }

    /**
     * 设置已读
     * @param $userId
     * @param $id
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function setRead($userId, $id)
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
     * 发送已读
     * @param $userId
     * @param $id
     * @return void
     */
    public function sendRead($userId, $id)
    {
        $data = [
            'type' => 'read',
            'id' => $id
        ];
        $websocketMessage = new WebsocketMessageService();
        $websocketMessage->send([$userId], $data);
    }

    /**
     * 队列发送已读
     * @param $userId
     * @param $id
     * @return void
     */
    public function queueSendRead($userId, $id)
    {
        $data = [
            'type' => 'read',
            'data' => [
                'type' => 'read',
                'user_id' => $userId,
                'id' => $id
            ]
        ];
        Queue::push('app\job\Message', $data, 'message');
    }

    /**
     * 设置全部已读
     * @param $userId
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function setAllRead($userId)
    {
        $messages = MessageModel::where('user_id', $userId)
            ->select();
        if ($messages->isEmpty()) {
            return;
        }
        $messages->update(['is_read' => 1, 'read_time' => time()]);
    }

    /**
     * 发送全部已读
     * @param $userId
     * @return void
     */
    public function sendAllRead($userId)
    {
        $data = [
            'type' => 'all_read'
        ];
        $websocketMessage = new WebsocketMessageService();
        $websocketMessage->send([$userId], $data);
    }

    /**
     * 队列发送已读
     * @param $userId
     * @return void
     */
    public function queueSendAllRead($userId)
    {
        $data = [
            'type' => 'read',
            'data' => [
                'type' => 'all_read',
                'user_id'=>$userId
            ]
        ];
        Queue::push('app\job\Message', $data, 'message');
    }
}