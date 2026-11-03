<?php

namespace app\desktop\controller\system\operation_log;

use app\desktop\controller\Base;
use app\helper\OperationLogHelper;
use app\validate\operation_log\TimeRangeDeleteValidate;
use Exception;
use think\exception\ValidateException;

class TimeRangeDelete extends Base
{
    /**
     * 删除
     */
    public function save()
    {
        $post = $this->request->post(['start_time' => '', 'end_time' => '']);
        try {
            validate(TimeRangeDeleteValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        try {
            $operationLogHelper = new OperationLogHelper();
            $count = $operationLogHelper->deleteByTimeRange($post['start_time'], $post['end_time']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功，共删除' . $count . '条操作日志');
    }
}
