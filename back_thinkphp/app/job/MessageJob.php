<?php

namespace app\job;

use app\service\Message;
use Exception;
use think\queue\Job;

class MessageJob
{
    public function fire(Job $job, $data)
    {
        $job->delete();

        if (empty($data) || empty($data['user_ids']) || !isset($data['title'])) {
            return;
        }

        $message = new Message();
        try {
            $message->sends($data['user_ids'], $data['title'], $data['content'], $data['url']);
        } catch (Exception $exception) {
            echo $exception->getMessage()."\r\n";
        }
    }

    public function failed($data)
    {

        // ...任务达到最大重试次数后，失败了
    }
}