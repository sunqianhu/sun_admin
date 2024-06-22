<?php

namespace app\desktop\controller\system\desktop\module;

use app\desktop\controller\Base;
use app\model\desktop\Permission as PermissionModel;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到首页权限集合
     */
    public function getIndexModules()
    {
        $get = $this->request->get(['name']);
        $query = PermissionModel::field('id,module_id,type_id,name,key,sort,remark');
        if (isset($get['name'])) {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('sort', 'asc');
        $query->append(['type_name']);
        $moduleModels = $query->select();
        $modules = $moduleModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        return $this->success('获取成功', $treeModules);
    }
}