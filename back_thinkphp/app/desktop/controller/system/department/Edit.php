<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use app\service\CrudService;
use app\validate\DepartmentValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        $id = $get['id'];

        $departmentModel = DepartmentModel::field('id,name,department_id,type,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->error('没有找到记录');
        }
        $department = $departmentModel->toArray();

        return $this->success('获取成功', $department);
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

        $departmentCrudService = new CrudService(DepartmentModel::class);
        try{
            $departmentCrudService->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}