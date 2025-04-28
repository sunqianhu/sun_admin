<?php

namespace app\desktop\controller\system\login_log;

use app\desktop\controller\Base;
use app\model\LoginLogModel;

class Index extends Base
{
    /**
     * 得到登录日志分页
     */
    public function getLoginLogPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'time' =>[], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = LoginLogModel::alias('ll')
            ->field('ll.*,u.name as user_name, d.name as department_name')
            ->leftJoin("user u", "ll.user_id = u.id")
            ->leftJoin("department d", "u.department_id = d.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query->whereBetweenTime('ll.time', intval($get['time'][0]), intval($get['time'][1]));
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
        $query->order('ll.id', 'desc');

        $loginLogPaginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $loginLogPaginateArray = $loginLogPaginate->toArray();

        return $this->getSuccessResonse('获取成功', $loginLogPaginateArray);
    }
}