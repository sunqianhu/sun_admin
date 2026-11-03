<?php

namespace app\desktop\controller\system\operation_log;

use app\desktop\controller\Base;
use app\model\OperationLogModel;
use app\validate\IdValidate;
use think\exception\ValidateException;

class Detail extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id' => 0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $operationLogModel = OperationLogModel::alias('ol')
            ->field('ol.*,u.name as user_name,d.name as department_name')
            ->leftJoin('user u', 'ol.user_id = u.id')
            ->leftJoin('department d', 'ol.department_id = d.id')
            ->where('ol.id', $get['id'])
            ->append(['terminal_name', 'response_business_code_name'])
            ->find();
        if (empty($operationLogModel)) {
            return $this->getErrorResponse('没有找到操作日志记录');
        }
        $operationLog = $operationLogModel->toArray();

        return $this->getSuccessResponse('获取成功', $operationLog);
    }
}
