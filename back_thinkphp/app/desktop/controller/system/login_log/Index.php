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
        $get = $this->request->get(['time' =>[], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query->whereBetweenTime('ll.time', intval($get['time'][0]), intval($get['time'][1]));
        }
        if ($get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->order('ll.id', 'desc');

        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $loginLogPaginate = $paginate->toArray();

        return $this->success('获取成功', $loginLogPaginate);
    }
}