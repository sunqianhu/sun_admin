<?php

namespace app\desktop\controller\system\role;

use app\desktop\controller\Base;
use app\helper\RoleHelper;
use app\helper\role\DesktopMenuHelper;
use app\helper\role\DesktopRouteHelper;
use app\helper\role\PermissionHelper;
use app\helper\role\RolePolicyHelper;
use app\helper\role\UserHelper;
use app\helper\user\DataScopeHelper;
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

            $permissionHelper = new PermissionHelper();
            $permissionHelper->deleteByRoleId($id);

            $desktopMenuHelper = new DesktopMenuHelper();
            $desktopMenuHelper->deleteByRoleId($id);

            $desktopRouteHelper = new DesktopRouteHelper();
            $desktopRouteHelper->deleteByRoleId($id);

            $rolePolicyHelper = new RolePolicyHelper();
            $rolePolicyHelper->deleteByRoleId($id);

            $userHelper = new UserHelper();
            $userHelper->deleteByRoleId($id);

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        $dataScopeHelper = new DataScopeHelper();
        $dataScopeHelper->clearCache();

        return $this->getSuccessResponse('删除成功');
    }
}
