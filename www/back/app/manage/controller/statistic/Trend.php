<?php

namespace app\manage\controller\statistic;

use app\manage\controller\Base;
use app\manage\validate\statistic\Trend as TrendValidate;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use think\exception\ValidateException;

class Trend extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $get = $this->request->get(['add_times' => []]);

        // 验证
        try {
            validate(TrendValidate::class)->scene('init')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

//        $query = InfoModel::field('add_time')
//            ->whereBetween('add_time', $get['add_times']);
//        $infoModels = $query->select();

        $days = [];
        for ($time = $startTime; $time < $endTime; $time += 24 * 60 * 60) {
            $day = [
                'name' => date('j日', $time),
                'full_name' => date('Y年m月j日', $time),
                'number' => rand(0, 50)
            ];

//            foreach ($infoModels as $infoModel) {
//                if ($infoModel->add_time < $time || $infoModel->add_time >= $time + 24 * 60 * 60) {
//                    continue;
//                }
//                $day['number']++;
//            }
            $days[] = $day;
        }

        return $this->success('获取成功', $days);
    }

    /**
     * 导出excel
     * @return void
     */
    public function exportExcel()
    {
        $get = $this->request->get(['add_times' => []]);

        // 验证
        try {
            validate(TrendValidate::class)->scene('export_excel')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_times'][0];
        $endTime = $get['add_times'][1];

        $days = [];
        for ($time = $startTime; $time < $endTime; $time += 24 * 60 * 60) {
            $day = [
                'name' => date('j日', $time),
                'full_name' => date('Y年m月j日', $time),
                'number' => rand(0, 50)
            ];

//            foreach ($infoModels as $infoModel) {
//                if ($infoModel->add_time < $time || $infoModel->add_time >= $time + 24 * 60 * 60) {
//                    continue;
//                }
//                $day['number']++;
//            }
            $days[] = $day;
        }

        //excel
        $spreadsheet = new Spreadsheet();
        $activeSheet = $spreadsheet->getActiveSheet();

        $activeSheet->setCellValue('A1', '日期');
        $activeSheet->setCellValue('B1', '订单数量');
        $row = 1;
        foreach ($days as $day) {
            $row++;
            $activeSheet->setCellValue('A' . $row, $day['full_name']);
            $activeSheet->setCellValue('B' . $row, $day['number']);
        }
        $activeSheet->getColumnDimension('A')->setAutoSize(true);
        $activeSheet->getColumnDimension('B')->setAutoSize(true);

        //输出
        header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        header("Content-Disposition: attachment;filename=example.xlsx");
        header("Cache-Control: max-age=0");

        $writer = new Xlsx($spreadsheet);
        $writer->save('php://output');
    }
}