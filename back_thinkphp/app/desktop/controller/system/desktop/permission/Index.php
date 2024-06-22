<?php

namespace app\desktop\controller\system\desktop\module;

use app\desktop\controller\Base;
use app\model\desktop\Module as ModuleModel;
use Sunqianhu\Helper\ArrayHandler;

class Index extends Base
{
    /**
     * 得到首页模块集合
     */
    public function getIndexModules()
    {
        $get = $this->request->get(['name']);
        $query = ModuleModel::field('id,module_id,type_id,name,key,sort,remark');
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