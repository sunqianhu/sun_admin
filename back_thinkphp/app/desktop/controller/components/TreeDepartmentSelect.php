<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\DepartmentService;
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
        $departmentService = new DepartmentService();
        $treeDepartment = $departmentService->getTreeDepartment();
        return $this->success('获取成功', $treeDepartment);
    }
}