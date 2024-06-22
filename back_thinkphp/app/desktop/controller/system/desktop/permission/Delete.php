<?php

namespace app\desktop\controller\system\desktop\module;

use app\desktop\controller\Base;
use app\model\desktop\Permission as PermissionModel;

class Index extends Base
{
    /**
     * 删除
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $childrenPermissionModel = PermissionModel::where('module_id', $id)->find();
        if (!empty($childrenPermissionModel)) {
            return $this->error('存在子权限，不能删除');
        }

        $moduleModel = PermissionModel::find($id);
        $moduleModel->delete();

        return $this->success('删除成功');
    }
}