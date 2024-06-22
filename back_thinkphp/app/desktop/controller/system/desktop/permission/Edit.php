<?php

namespace app\desktop\controller\system\desktop\module;

use app\desktop\controller\Base;
use app\model\desktop\Permission as PermissionModel;
use app\service\Dictionary as DictionaryService;
use Sunqianhu\Helper\ArrayHandler;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 初始化修改
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $moduleModel = PermissionModel::field('id,name,key,type_id,module_id,icon,path,component,api,layout,remark,keep_alive,show,sort,url')->find($id);
        if (empty($moduleModel)) {
            return $this->error('没有找到记录');
        }
        $moduleModel->append(['apis']);
        $module = $moduleModel->toArray();

        $moduleModels = PermissionModel::field('id, id as value,module_id,name as label')->order('sort', 'asc')->select();
        $modules = $moduleModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeModules = $arrayHandler->convertTree($modules, 'id', 'module_id', 'children');

        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('desktop_module_type');
        $layouts = $dictionaryService->getList('desktop_module_layout');

        $data = [
            'tree_modules' => $treeModules,
            'types' => $types,
            'layouts' => $layouts,
            'permission' => $module
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

        $moduleModel = PermissionModel::find($post['id']);
        if(empty($moduleModel)){
            return $this->error('没有找到权限记录');
        }
        $moduleModel->save($post);

        return $this->success('修改成功');
    }
}