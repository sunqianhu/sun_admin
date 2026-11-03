<?php

namespace app\job;

use app\helper\MessageHelper;
use Exception;
use think\facade\Log;
use think\queue\Job;

class Message
{
    public function fire(Job $job, $data)
    {
        if (empty($data) || !isset($data['type']) || !isset($data['data'])) {
            throw new Exception('消息任务数据不完整');
        }

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
        $job->delete();
    }

    public function failed($data, $exception)
    {
        $message = '消息任务执行失败：' . $exception->getMessage();
        $message .= '，任务数据：' . json_encode($data, JSON_UNESCAPED_UNICODE);
        Log::write($message, 'message_error');
    }
}
