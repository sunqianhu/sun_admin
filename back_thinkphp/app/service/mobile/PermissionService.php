<?php

namespace app\service\mobile;

use app\model\mobile\PermissionModel;
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
        $permissions = PermissionModel::field('id, permission_id, name')
            ->order('sort', 'asc')
            ->select();
        $permissions = $permissions->toArray();

        $arrayHandler = new ArrayHandler();
        $treePermission = $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
        return $treePermission;
    }

    /**
     * 得到带名称和key的树形权限
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
        $permissions = $permissions->toArray();

        $arrayHandler = new ArrayHandler();
        return $arrayHandler->convertTree($permissions, 'id', 'permission_id', 'children');
    }
}