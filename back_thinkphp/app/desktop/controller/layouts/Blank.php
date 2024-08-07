<?php

namespace app\desktop\controller\layouts;

use app\desktop\controller\Base;
use app\service\Watermark as WatermarkService;

class Blank extends Base
{
    /**
     * 得到水印
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getWatermark()
    {
        $watermarkService = new WatermarkService();
        $watermarkEntity = $watermarkService->getWatermark($this->session->userId);
        $watermark = $watermarkEntity->toArray();

        return $this->success('获取成功', $watermark);
    }
}