<?php

namespace app\desktop\controller\dictionary;

use app\desktop\controller\Base;
use app\helper\DictionaryHelper;
use app\model\DictionaryModel;
use app\validate\IdValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class Index extends Base
{
    /**
     * 得到分页
     * @return Response
     * @throws DbException
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
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();
        
        return $this->getSuccessResponse('获取成功', $paginate);
    }

    /**
     * 删除
     * @return Response
     * @throws DbException
     * @throws DataNotFoundException
     * @throws ModelNotFoundException
     */
    public function delete(){
        $post = $this->request->post(['id']);
        try {
            validate(IdValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try{
            $dictionaryHelper = new DictionaryHelper();
            $dictionaryHelper->delete($post['id']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('删除成功');
    }
}
