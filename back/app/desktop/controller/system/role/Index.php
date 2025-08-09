<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleDesktopMenuModel;
use app\model\RoleDesktopPermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleMobilePermissionModel;
use app\model\RoleModel;
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
            $roleModel = RoleModel::find($id);
            if(empty($roleModel)){
                throw new Exception('没有找到角色记录');
            }
            $roleModel->delete($id);

            $roleDesktopPermissionModels = RoleDesktopPermissionModel::where('role_id', $id)->select();
            $roleDesktopPermissionModels->delete();

            $roleDesktopMenuModels = RoleDesktopMenuModel::where('role_id', $id)->select();
            $roleDesktopMenuModels->delete();

            $roleDesktopRouteModels = RoleDesktopRouteModel::where('role_id', $id)->select();
            $roleDesktopRouteModels->delete();

            $roleMobilePermissionModels = RoleMobilePermissionModel::where('role_id', $id)->select();
            $roleMobilePermissionModels->delete();

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('删除成功');
    }
}