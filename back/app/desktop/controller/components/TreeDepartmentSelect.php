<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\department\TreeDepartmentHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class TreeDepartmentSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到树型单位列表
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeDepartment()
    {
        $get = $this->request->get(['department_id'=>0]);
        if(!is_numeric($get['department_id'])){
            return $this->getErrorResponse('department_id参数错误');
        }

        $treeDepartmentHelper = new TreeDepartmentHelper();
        $treeDepartment = $treeDepartmentHelper->getTreeDepartment($get['department_id']);
        return $this->getSuccessResponse('获取成功', $treeDepartment);
    }
}