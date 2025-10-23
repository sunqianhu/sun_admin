<?php

namespace app\job;

use app\helper\MessageHelper;
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
            $messageHelper = new MessageHelper();
            switch ($data['type']) {
                case 'message':
                    $messageHelper->sends($data['user_ids'], $data['title'], $data['content'], $data['url']);
                    break;
                case 'read':
                    $messageHelper->sendRead($data['user_id'], $data['id']);
                    break;
                case 'all_read':
                    $messageHelper->sendAllRead($data['user_id']);
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