<?php

namespace app\desktop\controller\system\login_log;

use app\desktop\controller\Base;
use app\model\LoginLogModel;
use app\validate\PaginationValidate;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 得到分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'times' =>[], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = LoginLogModel::alias('ll')
            ->field('ll.*,u.name as user_name, d.name as department_name')
            ->leftJoin("user u", "ll.user_id = u.id")
            ->leftJoin("department d", "u.department_id = d.id");
        if (!empty($get['times']) && count($get['times']) == 2) {
            $query->whereBetweenTime('ll.time', intval($get['times'][0]), intval($get['times'][1]));
        }
        if (!empty($get['department_ids'])) {
            $query->whereIn('ll.department_id', $get['department_ids']);
        }
        if ($get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->order('ll.id', 'desc');
        $query->append(['terminal_name']);

        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();

        return $this->getSuccessResponse('获取成功', $paginate);
    }
}
