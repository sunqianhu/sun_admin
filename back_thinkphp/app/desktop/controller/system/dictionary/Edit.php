<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\model\DictionaryModel;
use app\service\CrudService;
use app\validate\DictionaryValidate;
use app\validate\IdValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     *
     * @return \think\Response
     */
    public function init()
    {
        $get = $this->request->get(['id'=>0]);
        try {
            validate(IdValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }
        $id = $get['id'];

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
            validate(DictionaryValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $dictionaryCrudService = new CrudService(DictionaryModel::class);
        try{
            $dictionaryCrudService->update($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}