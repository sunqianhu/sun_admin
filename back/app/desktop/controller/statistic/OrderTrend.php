<?php

namespace app\desktop\controller\statistic;

use app\desktop\controller\Base;
use app\service\order\ExcelService;
use app\service\order\TrendStatisticService;
use app\validate\order\IndexSearchValidate;
use Exception;
use Sunqianhu\Helper\File;
use think\exception\ValidateException;
use think\Response;

class OrderTrend extends Base
{
    /**
     * 初始化
     * @return Response
     */
    public function init()
    {
        $get = $this->request->get(['add_times' => []]);

        try {
            validate(IndexSearchValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->getErrorResponse('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

        $trendStatisticService = new TrendStatisticService();
        try{
            $trend = $trendStatisticService->getTimeRangeTrend($startTime, $endTime);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('获取成功', $trend);
    }

    /**
     * 导出
     * @return Response
     * @throws Exception
     */
    public function exp()
    {
        $get = $this->request->get(['add_times' => []]);

        // 验证
        try {
            validate(IndexSearchValidate::class)->check($get);
        } catch (ValidateException $e) {
            return $this->getErrorResponse($e->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->getErrorResponse('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

        $excelService = new ExcelService();
        try{
            $path = $excelService->createTimeRangeTrendExcel($startTime, $endTime);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);

        return $this->getSuccessResonse('获取成功', $url);
    }
}