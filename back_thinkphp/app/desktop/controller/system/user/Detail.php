<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\LoginLogModel;
use app\model\OperationLogModel;
use app\model\UserModel;

class Detail extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $userModel = UserModel::field('id,account,name,phone,department_id,add_time,status,edit_time,last_login_time,last_login_ip')
            ->with(['roles', 'department'])
            ->find($id);
        $userModel->append(['status_name', 'role_names']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
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
            ->field('ol.*,u.name')
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
        return $this->success('获取成功', $data);
    }
}