<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\CrudService;
use app\model\DictionaryModel;
use Exception;

class Index extends Base
{
    /**
     * 得到字典分页
     * @return \think\Response
     * @throws \think\db\exception\DbException
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
        $dictionaryPaginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $dictionaryPaginateArray = $dictionaryPaginate->toArray();
        return $this->success('获取成功', $dictionaryPaginateArray);
    }

    /**
     * 删除
     * @return \think\Response
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $dictionaryCrudService = new CrudService(DictionaryModel::class);
        try{
            $dictionaryCrudService->delete($id);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('删除成功');
    }
}