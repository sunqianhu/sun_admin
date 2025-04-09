<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use app\service\CrudService;
use app\service\DepartmentService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到部门
     */
    public function getTreeDepartment()
    {
        $get = $this->request->get(['name'=>'']);

        $query = DepartmentModel::field('id,department_id,type,name,sort');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('sort', 'asc');
        $query->append(['type_name']);
        $departments = $query->select();
        $departments = $departments->toArray();

        $arrayHandler = new ArrayHandler();
        $treeDepartment = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        return $this->success('获取成功', $treeDepartment);
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

        $departmentCrudService = new CrudService(DepartmentModel::class);
        try{
            $departmentCrudService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}