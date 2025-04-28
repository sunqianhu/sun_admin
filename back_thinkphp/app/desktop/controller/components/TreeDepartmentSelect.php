<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\DepartmentService;
use app\validate\IdValidate;
use think\exception\ValidateException;
use think\Response;

class TreeDepartmentSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树型单位列表
     * @return Response
     */
    public function getTreeDepartment()
    {
        $get = $this->request->get(['department_id'=>0]);
        if(!is_numeric($get['department_id'])){
            return $this->getErrorResponse('department_id参数错误');
        }

        $departmentService = new DepartmentService();
        $treeDepartment = $departmentService->getTreeDepartment($get['department_id']);
        return $this->getSuccessResonse('获取成功', $treeDepartment);
    }
}