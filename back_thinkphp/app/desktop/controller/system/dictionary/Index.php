<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\DictionaryService;
use app\model\DictionaryModel;
use Exception;

class Index extends Base
{
    /**
     * 得到字典分页
     */
    public function getDictionaryPaginate()
    {
        $get = $this->request->get(['type' => '', 'key' => '', 'value' => '', 'size' => '30', 'page' => '1']);
        $query = DictionaryModel::field('id,type,key,value,sort');
        if ($get['type'] !== '') {
            $query->where('type', 'LIKE', '%' . $get['type'] . '%');
        }
        if ($get['key'] !== '') {
            $query->where('key', 'LIKE', '%' . $get['key'] . '%');
        }
        if ($get['value'] !== '') {
            $query->where('value', 'LIKE', '%' . $get['value'] . '%');
        }
        $query->order([
            'type' => 'asc',
            'sort' => 'asc'
        ]);
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $dictionaryPaginate = $paginate->toArray();
        return $this->success('获取成功', $dictionaryPaginate);
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

        $dictionary = new DictionaryService();
        try{
            $dictionary->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}