<?php

namespace app\desktop\controller\system\operation_log;

use app\desktop\controller\Base;
use app\model\OperationLogModel;

class Index extends Base
{

    /**
     * 得到操作日志
     */
    public function getOperationLogPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'time' => [], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = OperationLogModel::alias('ol')
            ->field('ol.*,u.name as user_name, d.name as department_name')
            ->leftJoin("user u", "ol.user_id = u.id")
            ->leftJoin("department d", "u.department_id = d.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query->whereBetweenTime('ol.time', intval($get['time'][0]), intval($get['time'][1]));
        }
        if (!empty($get['department_ids'])) {
            $query->whereIn('u.department_id', $get['department_ids']);
        }
        if ($get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->order('ol.id', 'desc');
        $operationLogPaginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $operationLogPaginateArray = $operationLogPaginate->toArray();

        return $this->getSuccessResonse('获取成功', $operationLogPaginateArray);
    }
}