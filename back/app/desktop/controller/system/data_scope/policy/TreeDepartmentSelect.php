<?php

namespace app\desktop\controller\system\data_scope\policy;

use app\desktop\controller\Base;
use app\helper\department\TreeDepartmentHelper;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

class TreeDepartmentSelect extends Base
{
    /**
     * 得到树型单位列表
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function getTreeDepartment()
    {
        $treeDepartmentHelper = new TreeDepartmentHelper();
        $treeDepartment = $treeDepartmentHelper->getTreeDepartment(0);
        return $this->getSuccessResponse('获取成功', $treeDepartment);
    }
}