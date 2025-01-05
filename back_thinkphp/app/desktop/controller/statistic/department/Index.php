<?php

namespace app\desktop\controller\statistic\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use app\validate\statistic\DepartmentValidate;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Index extends Base
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
            validate(DepartmentValidate::class)->scene('desktop_init')->check($get);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $departmentModels = DepartmentModel::select();
        $departments = [];
        foreach($departmentModels as $departmentModel){
//            $number = InfoModel::
//                ->whereBetween('add_time', $get['add_times'])
//                ->count();
            $number = rand(0,50);
            $department = [
                'name'=>$departmentModel->name,
                'number'=>$number
            ];
            $departments[] = $department;
        }
        $arrayHandler = new ArrayHandler();
        $arrayHandler->rsortTwoDimensional($departments, 'number');

        return $this->success('获取成功', $departments);
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
            validate(DepartmentValidate::class)->scene('desktop_export_excel')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_times']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $departmentModels = DepartmentModel::select();
        $departments = [];
        foreach($departmentModels as $departmentModel){
//            $number = InfoModel::
//                ->whereBetween('add_time', $get['add_times'])
//                ->count();
            $number = rand(0,50);
            $department = [
                'name'=>$departmentModel->name,
                'number'=>$number
            ];
            $departments[] = $department;
        }
        $arrayHandler = new ArrayHandler();
        $arrayHandler->rsortTwoDimensional($departments, 'number');

        //excel
        $spreadsheet = new Spreadsheet();
        $activeSheet = $spreadsheet->getActiveSheet();

        $activeSheet->setCellValue('A1', '部门');
        $activeSheet->setCellValue('B1', '订单数量');
        $row = 1;
        foreach ($departments as $department) {
            $row++;
            $activeSheet->setCellValue('A' . $row, $department['name']);
            $activeSheet->setCellValue('B' . $row, $department['number']);
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