<?php

namespace app\desktop\controller\system\dictionary;

use app\desktop\controller\Base;
use app\service\CrudService;
use app\model\DictionaryModel;
use Exception;
use think\Response;

class Index extends Base
{
    /**
     * 得到分页
     */
    public function getPaginate()
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
        $paginateArray = $paginate->toArray();
        return $this->getSuccessResonse('获取成功', $paginateArray);
    }

    /**
     * 删除
     * @return Response
     */
    public function delete(){
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $dictionaryCrudService = new CrudService(DictionaryModel::class);
        try{
            $dictionaryCrudService->delete($id);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResonse('删除成功');
    }
}