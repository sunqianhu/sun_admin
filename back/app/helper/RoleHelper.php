<?php

namespace app\helper;

use app\model\RoleModel;
use Exception;

class RoleHelper
{
    /**
     * 添加角色
     * @param array $data
     * @return int
     * @throws Exception
     */
    public function add($data)
    {
        $roleModel = new RoleModel();
        $roleModel->save($data);
        return $roleModel->id;
    }

    /**
     * 修改角色
     * @param $id
     * @param array $data
     * @return void
     * @throws Exception
     */
    public function edit($id, $data)
    {
        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            throw new Exception('没有找到角色记录');
        }

        $roleModel->save($data);
    }

    /**
     * 删除角色
     * @param $id
     * @return void
     * @throws Exception
     */
    public function delete($id)
    {
        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            throw new Exception('没有找到角色记录');
        }

        $roleModel->delete();
    }
}
