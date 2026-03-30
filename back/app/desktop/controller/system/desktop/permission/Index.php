<?php

namespace app\desktop\controller\system\desktop\permission;

use app\desktop\controller\Base;
use app\model\desktop\PermissionModel;
use Exception;
use Sunqianhu\Helper\Arr;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Response;

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

        $arr = new Arr();
        $treePermission = $arr->toTree($permissions, 'id', 'permission_id', 'children');

        return $this->getSuccessResponse('获取成功', $treePermission);
    }

    /**
     * 删除
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $permissionModel = PermissionModel::find($id);
        if (empty($permissionModel)) {
            return $this->getErrorResponse('没有找到记录');
        }

        try{
            $permissionModel->delete();
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}