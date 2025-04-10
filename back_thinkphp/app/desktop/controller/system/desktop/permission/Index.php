<?php

namespace app\desktop\controller\system\desktop\permission;

use app\desktop\controller\Base;
use app\model\desktop\PermissionModel;
use app\service\CrudService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到权限列表
     */
    public function getTreePermission()
    {
        $get = $this->request->get(['name', 'key']);
        $query = PermissionModel::field('id,permission_id,name,key,sort');
        if (isset($get['name'])) {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        if (isset($get['key'])) {
            $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        $query->order('sort', 'asc');
        $permissionModels = $query->select();
        $permissions = $permissionModels->toArray();

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

        $permissionCrudService = new CrudService(PermissionModel::class);
        try{
            $permissionCrudService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}