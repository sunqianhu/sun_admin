<?php

namespace app\mobile\controller;

use app\model\UserModel;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class Index extends Base
{
    public array $noApiAuthActions = ['init'];

    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $userModel = UserModel::field('avatar,name,department_id')
            ->append(['avatar_url', 'department_name'])
            ->find($this->userId);
        if(empty($user)){
            return $this->getErrorResponse('用户不存在');
        }
        $user = $userModel->toArray();

        $data = [
            'user'=>$user
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }
}