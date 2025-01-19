<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\DepartmentService;

class TreeDepartmentSelect extends Base
{
    public $noApiAuthActions = [
        'getTreeDepartment'
    ];

    /**
     * 得到树型单位列表
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeDepartment()
    {
        $department = new DepartmentService();
        $treeDepartment = $department->getTreeDepartment();
        return $this->success('获取成功', $treeDepartment);
    }
}