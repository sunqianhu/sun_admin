<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\MessageHelper;
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
            return $this->getErrorResponse($exception->getError());
        }

        $messageHelper = new MessageHelper();
        try{
            $messageHelper->setRead($this->request->userId, $post['id']);
            $messageHelper->sendReadByQueue($this->request->userId, $post['id']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('设置成功');
    }
}