<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;
use app\model\RoleModel;
use app\service\CrudService;
use Exception;
use think\facade\Db;

class Index extends Base
{
    /**
     * 得到角色分页
     */
    public function getRolePaginate()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('id', 'asc');
        $rolePaginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $rolePaginateArray = $rolePaginate->toArray();

        return $this->success('获取成功', $rolePaginateArray);
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

        Db::startTrans();
        try{
            $roleCrudService = new CrudService(RoleModel::class);
            $roleCrudService->delete($id);

            $roleDesktopPermissionCrudService = new CrudService(RoleDesktopPermissionModel::class);
            $roleDesktopPermissionCrudService->fieldDelete('role_id', $id);

            $roleDesktopMenuCrudService = new CrudService(RoleDesktopMenuModel::class);
            $roleDesktopMenuCrudService->fieldDelete('role_id', $id);

            $roleDesktopRouteCrudService = new CrudService(RoleDesktopRouteModel::class);
            $roleDesktopRouteCrudService->fieldDelete('role_id', $id);

            $roleMobilePermissionCrudService = new CrudService(RoleMobilePermissionModel::class);
            $roleMobilePermissionCrudService->fieldDelete('role_id', $id);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}