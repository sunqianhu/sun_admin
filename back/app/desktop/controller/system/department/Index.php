<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use Exception;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

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

        return $this->getSuccessResonse('获取成功', $treeDepartment);
    }

    /**
     * 删除
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $departmentModel = DepartmentModel::find($id);
        if(empty($departmentModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $departmentModel->delete();
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('删除成功');
    }
}