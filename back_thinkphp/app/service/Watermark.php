<?php

namespace app\service;

use app\model\UserModel;
use Exception;

class Watermark
{
    /**
     * 得到水印
     * @param $userId
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getWatermark($userId)
    {
        $user = UserModel::field('id,name')->find($userId);
        if (empty($user)) {
            throw new Exception('没有找到用户记录');
        }
        $watermark = [
            'user_id' => $user->id,
            'user_name' => $user->name,
            'date_time' => date('Y-m-d H:i:s')
        ];
        return $watermark;
    }
}