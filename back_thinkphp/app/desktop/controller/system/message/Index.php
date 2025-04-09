<?php

namespace app\desktop\controller\system\message;

use app\desktop\controller\Base;
use app\model\MessageModel;
use app\service\MessageService;

class Index extends Base
{
    public $isApiAuth = false;

    /**
     * 得到系统消息分页
     */
    public function getMessagePaginate()
    {
        $get = $this->request->get(['times' =>[], 'size' => '30', 'page' => '1']);

        $query = MessageModel::field('id, add_time,title,url,content,is_read');
        if (!empty($get['times']) && count($get['times']) == 2) {
            $query->whereBetweenTime('add_time', intval($get['times'][0]), intval($get['times'][1]));
        }
        $query->order('id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $messagePaginate = $paginate->toArray();

        return $this->success('获取成功', $messagePaginate);
    }

    /**
     * 设置全部已读
     * @return \think\Response
     */
    public function setAllRead()
    {
        $messageService = new MessageService();
        try{
            $messageService->setAllRead($this->session->userId);
            $messageService->queueSendAllRead($this->session->userId);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('设置成功');
    }
}