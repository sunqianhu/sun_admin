<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\service\Department as DepartmentService;
use app\service\Dictionary as DictionaryService;
use app\validate\Department as DepartmentValidate;
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
        $departmentModel = DepartmentModel::field('id,name,department_id,type_id,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->error('没有找到记录');
        }
        $department = $departmentModel->toArray();

        $departmentService = new DepartmentService();
        $treeDepartments = $departmentService->getTreeDepartments();

        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('department_type');

        $data = [
            'tree_departments' => $treeDepartments,
            'department' => $department,
            'types'=>$types
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'department_id' => 0, 'type_id', 'name', 'sort']);

        //验证
        try {
            validate(DepartmentValidate::class)->scene('desktop_edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        if($post['id'] == $post['department_id']){
            return $this->error('上级部门不能和本部门相同');
        }

        $departmentService = new DepartmentService();
        try{
            $departmentService->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}