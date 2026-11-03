<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\model\RoleDataScopePolicyModel;
use app\model\RoleDesktopMenuModel;
use app\model\RolePermissionModel;
use app\model\RoleDesktopRouteModel;
use app\model\RoleModel;
use app\validate\PaginationValidate;
use Exception;
use think\exception\ValidateException;
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

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query->order('id', 'asc');
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();

        return $this->getSuccessResponse('获取成功', $paginate);
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

            $rolePermissionModels = RolePermissionModel::where('role_id', $id)->select();
            $rolePermissionModels->delete();

            $roleDesktopMenuModels = RoleDesktopMenuModel::where('role_id', $id)->select();
            $roleDesktopMenuModels->delete();

            $roleDesktopRouteModels = RoleDesktopRouteModel::where('role_id', $id)->select();
            $roleDesktopRouteModels->delete();

            $roleDataScopePolicyModels = RoleDataScopePolicyModel::where('role_id', $id)->select();
            $roleDataScopePolicyModels->delete();

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}
