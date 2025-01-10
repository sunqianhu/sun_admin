<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\service\Department;
use app\service\Dictionary;
use app\validate\DepartmentValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化页面
     */
    public function init()
    {
        $department = new Department();
        $treeDepartment = $department->getTreeDepartment();

        $dictionary = new Dictionary();
        $types = $dictionary->getList('department_type');

        $data = [
            'tree_departments'=>$treeDepartment,
            'types'=>$types
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['department_id' => 0, 'type_id', 'name', 'sort']);

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