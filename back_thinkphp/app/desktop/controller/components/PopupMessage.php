<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\Message;
use app\validate\MessageValidate;
use Exception;
use think\exception\ValidateException;

class PopupMessage extends Base
{
    public $isApiAuth = false;

    /**
     * 设置全部已读
     * @return void
     */
    public function setRead()
    {
        $post = $this->request->post(['id']);

        try {
            validate(MessageValidate::class)->scene('set_read')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $message = new Message();
        try{
            $message->setRead($this->session->userId, $post['id']);
            $message->queueSendRead($this->session->userId, $post['id']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('设置成功');
    }
}