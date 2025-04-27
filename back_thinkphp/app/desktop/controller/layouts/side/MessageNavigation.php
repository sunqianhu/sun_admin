<?php

namespace app\desktop\controller\layouts\side;

use app\desktop\controller\Base;
use app\service\MessageService;
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
        $messageService = new MessageService();
        try{
            $count = $messageService->getNoReadCount($this->userId);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('获取成功', $count);
    }
}