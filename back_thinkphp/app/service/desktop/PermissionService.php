<?php

namespace app\service\desktop;

use app\model\desktop\PermissionModel;
use app\service\CrudService;
use Exception;
use Sunqianhu\Helper\ArrayHandler;

class PermissionService extends CrudService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(PermissionModel::class);
    }

    /**
     * 得到树形权限
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreePermission()
    {
        $permissions = PermissionModel::field('id, permission_id, name, key')
            ->order('sort', 'asc')
            ->select();
        $permissionArrays = $permissions->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissionArrays, 'id', 'permission_id', 'children');
    }

    /**
     * 得到名称和key的树形权限
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getNameKeyTreePermission()
    {
        $permissions = PermissionModel::field('id, permission_id, name, key')
            ->order('sort', 'asc')
            ->append(['name_key'])
            ->select();
        $permissionArrays = $permissions->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissionArrays, 'id', 'permission_id', 'children');
    }

    /**
     * 是否有子权限
     * @param $id
     * @return void
     */
    public function hasChildrenPermission($id){
        $permission = PermissionModel::where('permission_id', $id)
            ->limit(0,1)
            ->find();
        if(!empty($permission)){
            return true;
        }
        return false;
    }
}