<?php

namespace app\helper;

use app\model\UserModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class WatermarkHelper
{
    /**
     * 得到水印
     * @param $userId
     * @return array
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function getWatermark($userId)
    {
        $userModel = UserModel::field('id,name')->find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        return [
            'user_id' => $userModel->id,
            'user_name' => $userModel->name,
            'date_time' => date('Y-m-d H:i:s')
        ];
    }
}