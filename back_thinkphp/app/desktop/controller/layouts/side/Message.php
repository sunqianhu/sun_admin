<?php

namespace app\desktop\controller\layouts\side;

use app\desktop\controller\Base;
use app\model\Message as MessageModel;
use app\service\Message as MessageService;

class Message extends Base
{
    /**
     * 全部已读
     * @return void
     */
    public function readAll()
    {
        $messageService = new MessageService();
        $messageService->readAll($this->session->userId);

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
            ->limit(0, 30)
            ->select();
        $messages = $messageModels->toArray();

        //设为已读
        if (!$messageModels->isEmpty()) {
            $messageService = new MessageService();
            $messageService->readAll($this->session->userId);
        }

        return $this->success('获取成功', $messages);
    }
}