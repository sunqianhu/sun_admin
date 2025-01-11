<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use app\service\Department;
use app\validate\DepartmentValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //部门
        $departmentModel = DepartmentModel::field('id,name,department_id,type,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->error('没有找到记录');
        }
        $departmentArray = $departmentModel->toArray();

        return $this->success('获取成功', $departmentArray);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'department_id' => 0, 'type', 'name', 'sort']);

        //验证
        try {
            validate(DepartmentValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if($post['id'] == $post['department_id']){
            return $this->error('上级部门不能和本部门相同');
        }

        $department = new Department();
        try{
            $department->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}