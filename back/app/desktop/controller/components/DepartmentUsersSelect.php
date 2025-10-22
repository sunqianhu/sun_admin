<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\department\DepartmentUserService;
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

        $departmentUserService = new DepartmentUserService();
        $users = $departmentUserService->getUsers($get['department_id']);
        return $this->getSuccessResponse('获取成功', $users);
    }

    /**
     * 是否存在用户
     * @param $departmentId
     * @return bool
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function isExistUsers($departmentId)
    {
        $UserModel = UserModel::field('id')
            ->where('department_id', $departmentId)
            ->limit(0,1)
            ->find();
        if(empty($UserModel)){
            return false;
        }
        return true;
    }
}