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
        if (empty($data) || !isset($data['type']) || !isset($data['data'])) {
            return;
        }

        try {
            $data = $data['data'];
            $messageService = new MessageService();
            switch ($data['type']) {
                case 'message':
                    $messageService->sends($data['user_ids'], $data['title'], $data['content'], $data['url']);
                    break;
                case 'read':
                    $messageService->sendRead($data['user_id'], $data['id']);
                    break;
                case 'all_read':
                    $messageService->sendAllRead($data['user_id']);
                    break;
                default:
                    throw new Exception('未知的消息类型');
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