<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\helper\MessageHelper;
use Exception;
use think\Response;

class MessageNavigation extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到未读数
     * @return Response
     */
    public function getNoReadCount()
    {
        $messageHelper = new MessageHelper();
        try{
            $count = $messageHelper->getNoReadCount($this->userId);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('获取成功', $count);
    }
}