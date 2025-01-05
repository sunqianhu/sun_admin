<?php

namespace app\desktop\controller\frame;

use app\desktop\controller\Base;
use app\model\MessageModel;
use app\service\Message as MessageService;

class Message extends Base
{
    public $isRouteAuth = false;

    /**
     * 设置全部已读
     * @return void
     */
    public function setAllRead()
    {
        $messageService = new MessageService();
        $messageService->setAllRead($this->session->userId);

        return $this->success('设置成功');
    }

    /**
     * 得到未读消息集合
     * @return void
     */
    public function getNoReadMessages()
    {
        if(empty($this->session->userId)){
            return $this->error('还没有登录');
        }
        
        //数据
        $messageModels = MessageModel::where("user_id", $this->session->userId)
            ->where("read", 0)
            ->order('id', 'desc')
            ->limit(0, 30)
            ->select();
        $messages = $messageModels->toArray();

        return $this->success('获取成功', $messages);
    }
}