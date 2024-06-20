<?php

namespace app\desktop\controller\system\mobile;

use app\desktop\controller\Base;
use app\model\mobile\Module as ModuleModel;
use app\validate\mobile\Module as ModuleValidate;
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
        $query = ModuleModel::field('id,module_id,name,key,sort,remark');
        if (isset($get['name'])) {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('sort', 'asc');
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

        $data = [
            'tree_modules' => $treeModules,
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['module_id' => 0, 'name'=>'', 'key'=>'', 'api' => '', 'remark'=>'', 'sort']);

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

        $moduleModel = ModuleModel::field('id,name,key,module_id,api,remark,sort')->find($id);
        if (empty($moduleModel)) {
            return $this->error('没有找到记录');
        }
        $moduleModel->append(['apis']);
        $module = $moduleModel->toArray();

        $moduleModels = ModuleModel::field('id, id as value,module_id,name as label')->order('sort', 'asc')->select();
        $modules = $moduleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        $data = [
            'tree_modules' => $treeModules,
            'module' => $module
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'module_id' => 0, 'name', 'key'=>'', 'api' => '', 'remark'=>'', 'sort']);

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