<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use Sunqianhu\Helper\thinkphp\Crud;
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
            return $this->getErrorResponse($exception->getError());
        }
        $id = $get['id'];

        $departmentModel = DepartmentModel::field('id,name,department_id,type,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $department = $departmentModel->toArray();

        return $this->getSuccessResonse('获取成功', $department);
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
            return $this->getErrorResponse($exception->getError());
        }
        if($post['id'] == $post['department_id']){
            return $this->getErrorResponse('上级部门不能和本部门相同');
        }

        $departmentCrud = new Crud(DepartmentModel::class);
        try{
            $departmentCrud->update($post['id'], $post);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('修改成功');
    }
}