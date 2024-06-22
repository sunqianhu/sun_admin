<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;

class Delete extends Base
{
    /**
     * 删除
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //子部门
        $childrenDepartmentModel = DepartmentModel::where('department_id', $id)->find();
        if (!empty($childrenDepartmentModel)) {
            return $this->error('存在子部门，不能删除');
        }

        $departmentModel = DepartmentModel::find($id);
        if(empty($departmentModel)){
            return $this->error('没有找到记录');
        }
        $departmentModel->delete();

        return $this->success('删除成功');
    }
}