<?php

namespace app\desktop\controller\system\desktop\module;

use app\desktop\controller\Base;
use app\service\Dictionary as DictionaryService;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 初始化添加页面
     */
    public function initAdd()
    {


        $dictionaryService = new DictionaryService();
        $types = $dictionaryService->getList('desktop_module_type');
        $layouts = $dictionaryService->getList('desktop_module_layout');

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
            validate(ModuleValidate::class)->scene('desktop_add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $moduleService = new ModuleService();
        $moduleService->add($post);

        return $this->success('添加成功');
    }
}