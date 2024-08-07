<?php

namespace app\job;

use app\service\Message as MessageService;
use Exception;
use think\queue\Job;

class Message
{
    public function fire(Job $job, $data)
    {
        $job->delete();

        if (empty($data) || empty($data['user_ids']) || empty($data['end_ids']) || !isset($data['title']) || !isset($data['url'])) {
            return;
        }

        $messageHelper = new MessageService();
        try {
            $messageHelper->send($data['user_ids'], $data['end_ids'], $data['title'], $data['url']);
        } catch (Exception $exception) {
            echo $exception->getMessage()."\r\n";
        }
    }

    public function failed($data)
    {

        // ...任务达到最大重试次数后，失败了
    }
}