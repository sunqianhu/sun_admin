<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\helper\department\DepartmentPathHelper;
use app\model\DepartmentModel;
use app\validate\DepartmentValidate;
use Exception;
use think\exception\ValidateException;
use think\facade\Db;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['department_id' => 0, 'type', 'name', 'sort']);

        try {
            validate(DepartmentValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        Db::startTrans();
        try{
            $departmentModel = new DepartmentModel();
            $departmentModel->save($post);
            $id = $departmentModel->id;

            $departmentPathHelper = new DepartmentPathHelper();
            $departmentPathHelper->updatePath($id);
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}