<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\user\DataScopeHelper;
use app\helper\department\UserHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class DepartmentUsersSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树型单位列表
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getUsers()
    {
        $get = $this->request->get(['department_id'=>0]);
        if(!is_numeric($get['department_id'])){
            return $this->getErrorResponse('department_id参数错误');
        }

        $dataScopeHelper = new DataScopeHelper();
        if(!$dataScopeHelper->canAccessDepartment($this->request->userId, 'global_department_access', $get['department_id'])){
            return $this->getErrorResponse('无权限访问该部门');
        }

        $userHelper = new UserHelper();
        $users = $userHelper->getUsers($get['department_id']);
        return $this->getSuccessResponse('获取成功', $users);
    }
}