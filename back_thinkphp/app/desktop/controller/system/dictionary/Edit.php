<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\model\Dictionary as DictionaryModel;
use app\service\Dictionary as DictionaryService;
use app\validate\Dictionary as DictionaryValidate;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     *
     * @return void
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        //部门
        $dictionaryModel = DictionaryModel::field('id,type,key,value,sort')->find($id);
        if (empty($dictionaryModel)) {
            return $this->error('没有找到记录');
        }
        $dictionary = $dictionaryModel->toArray();

        return $this->success('获取成功', $dictionary);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['id', 'type', 'key', 'value', 'sort']);

        //验证
        try {
            validate(DictionaryValidate::class)->scene('desktop_edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $dictionaryService = new DictionaryService();
            $dictionaryService->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}