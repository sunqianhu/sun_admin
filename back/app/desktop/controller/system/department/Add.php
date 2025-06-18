<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\model\DepartmentModel;
use Sunqianhu\Helper\thinkphp\Crud;
use app\validate\DepartmentValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['department_id' => 0, 'type', 'name', 'sort']);

        //验证
        try {
            validate(DepartmentValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $departmentCrud = new Crud(DepartmentModel::class);
        try{
            $departmentCrud->insert($post);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('添加成功');
    }
}