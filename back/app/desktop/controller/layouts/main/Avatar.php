<?php

namespace app\desktop\controller\layouts\main;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\desktop\SessionService;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Avatar extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到用户
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getUser()
    {
        $userModel = UserModel::field('id,name,avatar')
            ->append(['avatar_url'])
            ->find($this->userId);
        $user = $userModel->toArray();

        return $this->getSuccessResponse('获取成功', $user);
    }

    /**
     * 退出
     * @return Response
     * @throws \Exception
     */
    public function logout()
    {
        $sessionService = new SessionService();
        $sessionService->deleteSession($this->sessionId);

        return $this->getSuccessResponse("退出成功");
    }
}