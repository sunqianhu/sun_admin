<?php

namespace app\helper\department;

use app\model\DepartmentModel;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;

class DepartmentPathHelper
{
    /**
     * 更新部门路径
     * @param $departmentId
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function updatePath($departmentId)
    {
        $treeDepartmentByRecursiveHelper = new TreeDepartmentByRecursiveHelper();
        $descendantDepartmentIds = $treeDepartmentByRecursiveHelper->getDescendantDepartmentIdsWithCurrentId($departmentId);

        Db::startTrans();
        try{
            foreach($descendantDepartmentIds as $descendantDepartmentId){
                $path = $treeDepartmentByRecursiveHelper->getPath($descendantDepartmentId);
                $departmentModel = DepartmentModel::field('id')
                    ->find($descendantDepartmentId);
                $departmentModel->path = $path;
                $departmentModel->save();
            }
            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            throw $exception;
        }
    }

    /**
     * 得到路径
     * @param $departmentId
     * @return string
     */
    public function getPath($departmentId)
    {
        return DepartmentModel::where('id', $departmentId)->value('path') ?? '';
    }
}