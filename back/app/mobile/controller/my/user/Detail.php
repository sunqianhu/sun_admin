<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\model\UserModel;
use app\helper\SessionHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Detail extends Base
{
    public bool $isApiAuth = false;

    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $userModel = UserModel::field('id,avatar,name,department_id,phone')
            ->append(['avatar_url', 'department_name'])
            ->find($this->request->userId);
        if(empty($userModel)){
            return $this->getErrorResponse('用户不存在');
        }
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }

    /**
     * 退出
     * @return Response
     * @throws \Exception
     */
    public function logout()
    {
        $sessionHelper = new SessionHelper();
        $sessionHelper->delete($this->request->sessionId);

        return $this->getSuccessResponse("退出登录成功");
    }
}
