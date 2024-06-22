<?php

namespace app\service;

use app\model\User as UserModel;
use app\entity\Watermark as WatermarkEntity;
use Exception;

class Watermark
{
    /**
     * 得到水印
     * @param $userId
     * @return WatermarkEntity
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getWatermark($userId)
    {
        $userModel = UserModel::field('id,name')->find($userId);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }
        $watermarkEntity = new WatermarkEntity();
        $watermarkEntity->userId = $userModel->id;
        $watermarkEntity->userName = $userModel->name;
        $watermarkEntity->dateTime = date('Y-m-d H:i:s');
        return $watermarkEntity;
    }
}