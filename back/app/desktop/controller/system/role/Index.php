<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\helper\RoleHelper;
use app\helper\role\RoleDesktopMenuHelper;
use app\helper\role\RoleDesktopRouteHelper;
use app\helper\role\RolePermissionHelper;
use app\helper\role\RolePolicyHelper;
use app\helper\role\RoleUserHelper;
use app\helper\user\UserDataScopeHelper;
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
            $roleHelper = new RoleHelper();
            $roleHelper->delete($id);

            $rolePermissionHelper = new RolePermissionHelper();
            $rolePermissionHelper->deleteByRoleId($id);

            $roleDesktopMenuHelper = new RoleDesktopMenuHelper();
            $roleDesktopMenuHelper->deleteByRoleId($id);

            $roleDesktopRouteHelper = new RoleDesktopRouteHelper();
            $roleDesktopRouteHelper->deleteByRoleId($id);

            $rolePolicyHelper = new RolePolicyHelper();
            $rolePolicyHelper->deleteByRoleId($id);

            $roleUserHelper = new RoleUserHelper();
            $roleUserHelper->deleteByRoleId($id);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        $userDataScopeHelper = new UserDataScopeHelper();
        $userDataScopeHelper->clearCache();

        return $this->getSuccessResponse('删除成功');
    }
}
