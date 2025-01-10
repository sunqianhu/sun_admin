<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\Dictionary;
use app\model\DictionaryModel;
use Exception;

class Index extends Base
{
    /**
     * 得到字典列表
     */
    public function getDictionarys()
    {
        $get = $this->request->get(['type' => '', 'key' => '', 'value' => '', 'size' => '30', 'page' => '1']);
        $query = DictionaryModel::field('id,type,key,value,sort');
        if ($get['type'] !== '') {
            $query = $query->where('type', 'LIKE', '%' . $get['type'] . '%');
        }
        if ($get['key'] !== '') {
            $query = $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        if ($get['value'] !== '') {
            $query = $query->where('value', 'LIKE', '%' . $get['value'] . '%');
        }
        $query = $query->order([
            'type' => 'asc',
            'sort' => 'asc'
        ]);
        $dictionarys = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        return $this->success('获取成功', $dictionarys);
    }

    /**
     * 删除
     * @return \think\Response|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $dictionary = new Dictionary();
        try{
            $dictionary->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}