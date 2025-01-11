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
        $get = $this->request->get(['time' => [], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = OperationLogModel::alias('ol')
            ->field('ol.*,u.name')
            ->leftJoin("user u", "ol.user_id = u.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query->whereBetweenTime('ol.time', intval($get['time'][0]), intval($get['time'][1]));
        }
        if ($get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->order('ol.id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $operationLogPaginate = $paginate->toArray();

        return $this->success('获取成功', $operationLogPaginate);
    }
}