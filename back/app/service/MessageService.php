<?php

namespace app\service;

use app\model\MessageModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;
use think\facade\Queue;
use Exception;

class MessageService
{
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
            throw new Exception('接收用户和消息标题不能为空');
        }

        $messageModel = new MessageModel();
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
            $messageModel->save($data);
            $id = $messageModel->id;

            $data = [
                'type' => 'message',
                'id' => $id,
                'title' => $title,
                'content' => $content,
                'url' => $url,
                'add_time' => $time
            ];
            $websocketMessageService = new WebsocketMessageService();
            $websocketMessageService->send([$userId], $data);

            Db::commit();
        } catch (Exception $exception) {
            Db::rollback();
            throw $exception;
        }
        return $id;
    }

    /**
     * 发送多用户消息
     * @param $userIds
     * @param $title
     * @param string $content
     * @param string $url
     * @return array
     * @throws Exception
     */
    public function sends($userIds, $title, $content = '', $url = '')
    {
        if (empty($userIds) || $title === '') {
            throw new Exception('消息接收用户和消息标题不能为空');
        }

        $ids = [];
        foreach ($userIds as $userId) {
            $ids[] = $this->send($userId, $title, $content, $url);
        }

        return $ids;
    }

    /**
     * 通过队列发送消息列表
     * @param $userIds
     * @param $title
     * @param $content
     * @param $url
     * @return void
     * @throws Exception
     */
    public function sendsByQueue($userIds, $title, $content = '', $url = '')
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
        return MessageModel::where('user_id', $userId)
            ->where('is_read', 0)
            ->count();
    }

    /**
     * 设置已读
     * @param $userId
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function setRead($userId, $id)
    {
        $messageModel = MessageModel::where('user_id', $userId)
            ->where('id', $id)
            ->find();
        if (empty($messageModel)) {
            throw new Exception('没有找到记录');
        }
        $messageModel->save(['is_read' => 1, 'read_time' => time()]);
    }

    /**
     * 发送已读
     * @param $userId
     * @param $id
     * @return void
     * @throws Exception
     */
    public function sendRead($userId, $id)
    {
        $data = [
            'type' => 'read',
            'id' => $id
        ];
        $websocketMessageService = new WebsocketMessageService();
        $websocketMessageService->send([$userId], $data);
    }

    /**
     * 队列发送已读
     * @param $userId
     * @param $id
     * @return void
     */
    public function sendReadByQueue($userId, $id)
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
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function setAllRead($userId)
    {
        $messageModels = MessageModel::where('user_id', $userId)
            ->select();
        if ($messageModels->isEmpty()) {
            return;
        }
        $messageModels->update(['is_read' => 1, 'read_time' => time()]);
    }

    /**
     * 发送全部已读
     * @param $userId
     * @return void
     * @throws Exception
     */
    public function sendAllRead($userId)
    {
        $data = [
            'type' => 'all_read'
        ];
        $websocketMessageService = new WebsocketMessageService();
        $websocketMessageService->send([$userId], $data);
    }

    /**
     * 队列发送已读
     * @param $userId
     * @return void
     */
    public function sendAllReadByQueue($userId)
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