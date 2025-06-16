<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\DepartmentService;
use think\Response;

class DepartmentUsersSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树型单位列表
     * @return Response
     */
    public function getUsers()
    {
        $get = $this->request->get(['department_id'=>0]);
        if(!is_numeric($get['department_id'])){
            return $this->getErrorResponse('department_id参数错误');
        }

        $departmentService = new DepartmentService();
        $users = $departmentService->getUsers($get['department_id']);
        return $this->getSuccessResonse('获取成功', $users);
    }
}