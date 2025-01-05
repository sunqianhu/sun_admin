<?php

namespace app\desktop\controller\system\department;

use app\desktop\controller\Base;
use app\service\Department as DepartmentService;
use app\service\Dictionary;
use app\validate\DepartmentValidate as DepartmentValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化页面
     */
    public function init()
    {
        $departmentService = new DepartmentService();
        $treeDepartments = $departmentService->getTreeDepartments();

        $dictionary = new Dictionary();
        $types = $dictionary->getList('department_type');

        $data = [
            'tree_departments'=>$treeDepartments,
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

        $departmentService = new DepartmentService();
        try{
            $departmentService->add($post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('添加成功');
    }
}