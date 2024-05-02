<?php

namespace app\desktop\controller\system\desktop;

use app\desktop\controller\Base;
use app\desktop\validate\system\desktop\Module as ModuleValidate;
use app\helper\Dictionary as DictionaryHelper;
use app\model\desktop\Module as ModuleModel;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

/**
 * 模块管理
 */
class Module extends Base
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
        $query->append(['type_name', 'type_tag_type']);
        $moduleModels = $query->select();
        $modules = $moduleModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        return $this->success('获取成功', $treeModules);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        $moduleModels = ModuleModel::field('id, id as value, module_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $modules = $moduleModels->toArray();

        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        $dictionaryHelper = new DictionaryHelper();
        $types = $dictionaryHelper->getList('desktop_module_type');
        $layouts = $dictionaryHelper->getList('desktop_module_layout');

        $data = [
            'tree_modules' => $treeModules,
            'types' => $types,
            'layouts' => $layouts
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['module_id' => 0, 'type_id' => 0, 'name'=>'', 'key'=>'', 'path'=>'', 'component', 'icon', 'url'=>'', 'api' => '', 'layout'=>'', 'remark'=>'', 'keep_alive', 'show', 'sort']);

        //验证
        try {
            validate(ModuleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $moduleModel = new ModuleModel();
        $moduleModel->save($post);

        return $this->success('添加成功');
    }

    /**
     * 初始化修改
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $moduleModel = ModuleModel::field('id,name,key,type_id,module_id,icon,path,component,api,layout,remark,keep_alive,show,sort,url')->find($id);
        if (empty($moduleModel)) {
            return $this->error('没有找到记录');
        }
        $moduleModel->append(['apis']);
        $module = $moduleModel->toArray();

        $moduleModels = ModuleModel::field('id, id as value,module_id,name as label')->order('sort', 'asc')->select();
        $modules = $moduleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        $dictionaryHelper = new DictionaryHelper();
        $types = $dictionaryHelper->getList('desktop_module_type');
        $layouts = $dictionaryHelper->getList('desktop_module_layout');

        $data = [
            'tree_modules' => $treeModules,
            'types' => $types,
            'layouts' => $layouts,
            'module' => $module
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'module_id' => 0, 'type_id' => 0, 'name', 'key'=>'', 'icon'=>'', 'path'=>'', 'component'=>'', 'api' => '', 'url'=>'', 'layout' => '', 'remark'=>'', 'keep_alive', 'show', 'sort']);

        //验证
        try {
            validate(ModuleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $moduleModel = ModuleModel::find($post['id']);
        if(empty($moduleModel)){
            return $this->error('没有找到模块记录');
        }
        $moduleModel->save($post);

        return $this->success('修改成功');
    }

    /**
     * 删除
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $childrenModuleModel = ModuleModel::where('module_id', $id)->find();
        if (!empty($childrenModuleModel)) {
            return $this->error('存在子模块，不能删除');
        }

        $moduleModel = ModuleModel::find($id);
        $moduleModel->delete();

        return $this->success('删除成功');
    }
}