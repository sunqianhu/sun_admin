<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\LoginLog as LoginLogModel;
use app\model\OperationLog as OperationLogModel;
use app\model\User as UserModel;
use app\service\User as UserHelper;

class Detail extends Base
{
    /**
     * 详情
     */
    public function detail()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $userModel = UserModel::field('id,account,name,phone,department_id,add_time,status_id,edit_time,login_time,login_ip')
            ->with(['roles', 'department'])
            ->find($id);
        $userModel->append(['status_name']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }

        $user = $userModel->toArray();
        $userService = new UserHelper();
        $user['role_name_string'] = $userService->getRoleNameString($userModel->roles, '，');

        //登录日志
        $loginLogModels = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ll.id', 'desc')
            ->limit(10)
            ->select();
        $loginLogs = $loginLogModels->toArray();

        //操作日志
        $operationLogModels = OperationLogModel::alias('ol')
            ->field('ol.*,u.name')
            ->leftJoin("user u", "ol.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ol.id', 'desc')
            ->limit(10)
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