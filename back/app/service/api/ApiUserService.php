<?php

namespace app\service\api;

use app\model\api\SessionModel;
use Exception;

class ApiUserService
{
    /**
     * 下线
     * @param $id
     * @return void
     * @throws Exception
     */
    public function offLine($id)
    {
        $sessionModels = SessionModel::where('user_id', $id)->select();
        if ($sessionModels->isEmpty()) {
            throw new Exception('没有找到会话记录');
        }
        $sessionModels->delete();
    }
}