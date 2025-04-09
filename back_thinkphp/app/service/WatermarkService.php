<?php

namespace app\service;

use app\model\UserModel;
use Exception;

class WatermarkService
{
    /**
     * 得到水印
     * @param $userId
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
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