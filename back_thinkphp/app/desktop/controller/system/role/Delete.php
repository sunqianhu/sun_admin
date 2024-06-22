<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\Role as RoleModel;
use app\model\RoleDesktopModule as RoleDesktopModuleModel;
use app\model\RoleMobileModule as RoleMobileModuleModel;

class Delete extends Base
{
    /**
     * 删除
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->delete();
        RoleDesktopModuleModel::where('role_id', $roleModel->id)->delete();
        RoleMobileModuleModel::where('role_id', $roleModel->id)->delete();

        return $this->success('删除成功');
    }
}