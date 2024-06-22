<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到部门
     */
    public function getDepartments()
    {
        $get = $this->request->get(['name'=>'']);

        $query = DepartmentModel::field('id,department_id,type_id,name,sort');
        if ($get['name'] !== '') {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('sort', 'asc');
        $query->append(['type_name']);
        $departmentModels = $query->select();
        $departments = $departmentModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        return $this->success('获取成功', $treeDepartments);
    }
}