<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\MessageService;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;
use think\Response;

class PopupMessage extends Base
{
    public bool $isApiAuth = false;

    /**
     * 设置已读
     * @return Response
     */
    public function setRead()
    {
        $post = $this->request->post(['id']);

        try {
            validate(IdValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $messageService = new MessageService();
        try{
            $messageService->setRead($this->userId, $post['id']);
            $messageService->queueSendRead($this->userId, $post['id']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('设置成功');
    }
}