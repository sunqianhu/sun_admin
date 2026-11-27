<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\helper\department\PathHelper;
use app\helper\department\TreeDepartmentHelper;
use app\model\DepartmentModel;
use app\validate\DepartmentValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Db;

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

        $departmentModel = DepartmentModel::field('id,name,department_id,type,sort')
            ->find($id);
        if (empty($departmentModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $department = $departmentModel->toArray();

        return $this->getSuccessResponse('获取成功', $department);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'department_id' => 0, 'type', 'name', 'sort']);

        try {
            validate(DepartmentValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        $treeDepartmentHelper = new TreeDepartmentHelper();
        $descendantDepartmentIds = $treeDepartmentHelper->getDescendantDepartmentIdsWithCurrentId($post['id']);
        if (in_array($post['department_id'], $descendantDepartmentIds)) {
            return $this->getErrorResponse('上级部门不能是本部门或本部门的子孙部门');
        }

        $departmentModel = DepartmentModel::find($post['id']);
        if(empty($departmentModel)){
            return $this->getErrorResponse('没有找到记录');
        }

        Db::startTrans();
        try{
            $departmentModel->save($post);

            $pathHelper = new PathHelper();
            $pathHelper->updatePath($departmentModel->id);
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}