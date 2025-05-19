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
use think\Response;

class Index extends Base
{
    /**
     * 得到分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('id', 'asc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginateArray = $paginate->toArray();

        return $this->getSuccessResonse('获取成功', $paginateArray);
    }

    /**
     * 删除
     * @return Response
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        Db::startTrans();
        try{
            $roleCrudService = new CrudService(RoleModel::class);
            $roleCrudService->delete($id);

            $roleDesktopPermissionCrudService = new CrudService(RoleDesktopPermissionModel::class);
            $roleDesktopPermissionCrudService->deleteByField('role_id', $id);

            $roleDesktopMenuCrudService = new CrudService(RoleDesktopMenuModel::class);
            $roleDesktopMenuCrudService->deleteByField('role_id', $id);

            $roleDesktopRouteCrudService = new CrudService(RoleDesktopRouteModel::class);
            $roleDesktopRouteCrudService->deleteByField('role_id', $id);

            $roleMobilePermissionCrudService = new CrudService(RoleMobilePermissionModel::class);
            $roleMobilePermissionCrudService->deleteByField('role_id', $id);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('删除成功');
    }
}