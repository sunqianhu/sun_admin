<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Detail extends Base
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
        $userModel = UserModel::field('id,account,name,phone,last_login_time,last_login_ip,department_id,avatar,big_avatar')
            ->append(['department_name', 'avatar_url', 'big_avatar_url'])
            ->find($this->userId);
        $user = $userModel->toArray();
        return $this->getSuccessResponse('获取成功', $user);
    }
}