<?php

namespace app\desktop\controller\system\mobile\permission;

use app\desktop\controller\Base;
use app\model\mobile\PermissionModel;
use app\service\mobile\Permission;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到权限列表
     */
    public function getPermissions()
    {
        $get = $this->request->get(['name', 'key']);
        $query = PermissionModel::field('id,permission_id,name,key,sort');
        if (isset($get['name'])) {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        if (isset($get['key'])) {
            $query = $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        $query = $query->order('sort', 'asc');
        $permissions = $query->select();
        $permissions = $permissions->toArray();

        $arrayHandler = new ArrayHandler();
        $treePermission = $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');

        return $this->success('获取成功', $treePermission);
    }

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $permission = new Permission();
        try{
            $permission->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}