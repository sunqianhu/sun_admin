<?php

namespace app\desktop\controller\layouts\side\user;

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
        $userModel = UserModel::field('id,account,name,phone,last_login_time,last_login_ip,department_id')
            ->append(['department_name'])
            ->find($this->session->userId);
        $user = $userModel->toArray();
        return $this->success('获取成功', $user);
    }
}