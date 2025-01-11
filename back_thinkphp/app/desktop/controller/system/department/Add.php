<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\service\Department;
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
            return $this->error($exception->getError());
        }

        $department = new Department();
        try{
            $department->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}