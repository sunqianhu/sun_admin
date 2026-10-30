<?php

namespace app\desktop\controller\system\session;

use app\desktop\controller\Base;
use app\helper\SessionHelper;
use app\model\SessionModel;
use app\validate\SessionValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class Extend extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id' => 0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $sessionModel = SessionModel::field('id,name,expire_time')->find($get['id']);
        if (empty($sessionModel)) {
            return $this->getErrorResponse('没有找到会话记录');
        }
        $session = $sessionModel->toArray();

        return $this->getSuccessResponse('获取成功', $session);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'expire_time']);
        try {
            validate(SessionValidate::class)->scene('extend')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        try {
            $sessionHelper = new SessionHelper();
            $sessionHelper->extend($post['id'], (int) $post['expire_time']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('延期成功');
    }
}
