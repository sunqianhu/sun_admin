<?php

namespace app\desktop\controller\layouts\side;

use app\desktop\controller\Base;
use app\service\Message;

class MessageNavigation extends Base
{
    public $isApiAuth = false;

    /**
     * 得到未读数
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getNoReadCount()
    {
        $message = new Message();
        try{
            $count = $message->getNoReadCount($this->session->userId);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('获取成功', $count);
    }
}