<?php

namespace app\desktop\controller\statistic;

use app\desktop\controller\Base;
use app\service\order\ExcelService;
use app\service\order\StatisticService;
use app\validate\order\IndexSearchValidate;
use app\validate\statistic\TrendValidate;
use Exception;
use Sunqianhu\Helper\File;
use think\exception\ValidateException;
use function app\desktop\controller\statistic\trend\rand;

class OrderTrend extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $get = $this->request->get(['add_times' => []]);

        try {
            validate(IndexSearchValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

        $statisticService = new StatisticService();
        try{
            $trend = $statisticService->getTimeRangeTrend($startTime, $endTime);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('获取成功', $trend);
    }

    /**
     * 导出
     * @return \think\Response
     */
    public function exp()
    {
        $get = $this->request->get(['add_times' => []]);

        // 验证
        try {
            validate(IndexSearchValidate::class)->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

        $excelService = new ExcelService();
        try{
            $path = $excelService->createTimeRangeTrendExcel($startTime, $endTime);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);

        return $this->success('获取成功', $url);
    }
}