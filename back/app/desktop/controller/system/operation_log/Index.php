<?php

namespace app\desktop\controller\system\operation_log;

use app\desktop\controller\Base;
use app\model\OperationLogModel;
use app\validate\PaginationValidate;
use think\exception\ValidateException;

class Index extends Base
{

    /**
     * 得到操作日志
     */
    public function getPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'terminal'=>'', 'response_business_code'=>'', 'times' => [], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = OperationLogModel::alias('ol')
            ->field('ol.id,ol.department_id,ol.user_id,ol.terminal,ol.api,ol.request_method,ol.response_http_code,ol.response_business_code,ol.duration,ol.ip,ol.time,u.name as user_name,d.name as department_name')
            ->leftJoin("user u", "ol.user_id = u.id")
            ->leftJoin("department d", "u.department_id = d.id");
        if (!empty($get['times']) && count($get['times']) == 2) {
            $query->whereBetweenTime('ol.time', intval($get['times'][0]), intval($get['times'][1]));
        }
        if (!empty($get['department_ids'])) {
            $query->whereIn('ol.department_id', $get['department_ids']);
        }
        if ($get['terminal'] !== '') {
            $query->where('ol.terminal', $get['terminal']);
        }
        if ($get['response_business_code'] !== '') {
            $query->where('ol.response_business_code', $get['response_business_code']);
        }
        if ($get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->order('ol.id', 'desc');
        $query->append(['terminal_name', 'response_business_code_name']);
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();

        return $this->getSuccessResponse('获取成功', $paginate);
    }
}
