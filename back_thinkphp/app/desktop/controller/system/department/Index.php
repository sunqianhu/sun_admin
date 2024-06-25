<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\service\Department as DepartmentService;
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

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $departmentService = new DepartmentService();
        try{
            $departmentService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}