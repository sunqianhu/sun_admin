<?php

namespace app\service\desktop;

use app\model\desktop\Module as ModuleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class Module
{
    /**
     * 得到树形模块
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getTreeModules()
    {
        $moduleModels = ModuleModel::field('id, module_id, name')
            ->order('sort', 'asc')
            ->select();
        $modules = $moduleModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');
        return $treeModules;
    }

    /**
     * 添加
     * @param $data
     * @return void
     */
    public function add($data)
    {
        $moduleModel = new ModuleModel();
        $moduleModel->save($data);
    }

    /**
     * 修改
     * @param $id
     * @param $data
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function edit($id, $data){
        $moduleModel = ModuleModel::find($id);
        if(empty($moduleModel)){
            throw new Exception('没有找到记录');
        }
        $moduleModel->save($data);
    }

    /**
     * 删除
     * @param $id
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     * @throws Exception
     */
    public function delete($id){
        $moduleModel = ModuleModel::find($id);
        if(empty($moduleModel)){
            throw new Exception('没有找到记录');
        }
        $moduleModel->delete();
    }

    public function getRoutes()
    {

    }

    public function getPermissions()
    {

    }

    /**
     * 得到主布局第一个页面模块id
     * @param $treeModules
     * @return int|mixed
     */
    public function getMainFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "main" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getMainFirstPageId($treeModule['children']);
        }

        return 0;
    }

    /**
     * 得到空白布局第一个页面模块id
     * @param $treeModules 
     * @return int|mixed
     */
    public function getBlankFirstPageId($treeModules)
    {
        foreach($treeModules as $treeModule){
            if($treeModule['layout'] == "blank" && $treeModule['type_id'] == 2){
                return $treeModule['id'];
            }
            if(empty($treeModule['children'])){
                continue;
            }

            return $this->getBlankFirstPageId($treeModule['children']);
        }

        return 0;
    }
}