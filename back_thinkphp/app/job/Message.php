<?php

namespace app\job;

use app\service\MessageService;
use Exception;
use think\queue\Job;

class Message
{
    public function fire(Job $job, $data)
    {
        $job->delete();
        if (empty($data) || empty($data['type'])) {
            return;
        }

        $data = $data['data'];
        $message = new MessageService();
        try {
            switch ($data['type']) {
                case 'message':
                    $message->sends($data['user_ids'], $data['title'], $data['content'], $data['url']);
                    break;
                case 'read':
                    $message->sendRead($data['user_id'], $data['id']);
                    break;
                case 'all_read':
                    $message->sendAllRead($data['user_id']);
                    break;
                default:
                    throw new Exception('未知的消息类型');
                    return;
            }
        } catch (Exception $exception) {
            echo $exception->getMessage() . "\r\n";
        }
    }

    public function failed($data)
    {

        // ...任务达到最大重试次数后，失败了
    }
}