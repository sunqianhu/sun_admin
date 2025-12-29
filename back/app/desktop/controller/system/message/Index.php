<?php

namespace app\desktop\controller\system\message;

use app\desktop\controller\Base;
use app\model\MessageModel;
use app\helper\MessageHelper;
use Exception;
use think\Response;

class Index extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['times' =>[], 'size' => '30', 'page' => '1']);

        $query = MessageModel::field('id, add_time,title,url,content,is_read');
        if (!empty($get['times']) && count($get['times']) == 2) {
            $query->whereBetweenTime('add_time', intval($get['times'][0]), intval($get['times'][1]));
        }
        $query->where('user_id', $this->userId)
            ->order('id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginateArray = $paginate->toArray();

        return $this->getSuccessResponse('获取成功', $paginateArray);
    }

    /**
     * 设置全部已读
     * @return Response
     */
    public function setAllRead()
    {
        $messageHelper = new MessageHelper();
        try{
            $messageHelper->setAllRead($this->userId);
            $messageHelper->sendAllReadByQueue($this->userId);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('设置成功');
    }
}