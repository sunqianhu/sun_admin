<?php

namespace app\desktop\controller\container\main;

use app\desktop\controller\Base;
use app\model\Message as MessageModel;

class Message extends Base
{
    /**
     * 全部已读
     * @return void
     */
    public function readAll()
    {
        $messageModels = MessageModel::where('user_id', $this->session->userId)
            ->where('read', 0)
            ->select();
        if ($messageModels->isEmpty()) {
            return $this->success('设置成功');
        }
        $messageModels->save([
            'read' => 1
        ]);
        return $this->success('设置成功');
    }

    /**
     * 获取未读消息
     * @return void
     */
    public function getNoReads()
    {
        //数据
        $messageModels = MessageModel::where("user_id", $this->session->userId)
            ->where("read", 0)
            ->order('id', 'desc')
            ->limit(0, 50)
            ->select();
        $messages = $messageModels->toArray();

        //设为已读
        if (!$messageModels->isEmpty()) {
            $messageModels = MessageModel::where("user_id", $this->session->userId)
                ->where("read", 0)
                ->select();
            $messageModels->save([
                'read' => 1
            ]);
        }

        return $this->success('获取成功', $messages);
    }
}