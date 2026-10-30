<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\LoginLogModel;
use app\model\OperationLogModel;
use app\model\UserModel;
use app\validate\IdValidate;
use think\exception\ValidateException;

class Detail extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        $userModel = UserModel::field('id,account,name,phone,department_id,add_time,status,edit_time,last_login_time,last_login_ip,avatar,big_avatar')
            ->with(['roles', 'department'])
            ->append(['status_name', 'role_names', 'avatar_url', 'big_avatar_url'])
            ->find($id);
        if (empty($userModel)) {
            return $this->getErrorResponse('没有找到记录');
        }

        $user = $userModel->toArray();
        $user['role_name_string'] = implode('，', $userModel->role_names);

        //登录日志
        $loginLogModels = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ll.id', 'desc')
            ->limit(5)
            ->select();
        $loginLogs = $loginLogModels->toArray();

        //操作日志
        $operationLogModels = OperationLogModel::alias('ol')
            ->field('ol.id,ol.department_id,ol.user_id,ol.terminal,ol.api,ol.request_method,ol.ip,ol.time,u.name')
            ->leftJoin("user u", "ol.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ol.id', 'desc')
            ->limit(5)
            ->select();
        $operationLogs = $operationLogModels->toArray();

        $data = [
            'user' => $user,
            'login_logs'=>$loginLogs,
            'operation_logs'=>$operationLogs
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }
}
