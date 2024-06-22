<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Department as DepartmentModel;
use app\service\Dictionary as DictionaryService;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化页面
     */
    public function init()
    {
        $departmentModels = DepartmentModel::field('id, id as value, department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('department_type');

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

        $departmentModel = new DepartmentModel();
        $departmentModel->save($post);

        return $this->success('添加成功');
    }
}