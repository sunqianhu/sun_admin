<?php

namespace app\service\order;

use app\service\FileService;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class ExcelService
{
    /**
     * 创建时间范围趋势excel
     * @param $startTime
     * @param $endTime
     * @return string
     * @throws \Exception
     */
    public function createTimeRangeTrendExcel($startTime, $endTime)
    {
        $statistic = new StatisticService();
        $trend = $statistic->getTimeRangeTrend($startTime, $endTime);

        //excel
        $spreadsheet = new Spreadsheet();
        $activeSheet = $spreadsheet->getActiveSheet();

        $activeSheet->setCellValue('A1', '日期');
        $activeSheet->setCellValue('B1', '订单数量');
        $row = 1;
        foreach ($trend as $day) {
            $row++;
            $activeSheet->setCellValue('A' . $row, $day['full_name']);
            $activeSheet->setCellValue('B' . $row, $day['count']);
        }
        $activeSheet->getColumnDimension('A')->setAutoSize(true);
        $activeSheet->getColumnDimension('B')->setAutoSize(true);

        $file = new FileService();
        $dir = $file->makeModuleDir('order');
        $fileName = md5(time().'_sun_'.rand(1000, 9999)).'.xlsx';
        $path = $dir.$fileName;
        $fullPath = $file->getFullPath($path);

        $writer = new Xlsx($spreadsheet);
        $writer->save($fullPath);

        return $path;
    }
}