<?php

namespace app\desktop\controller\dictionary;

use app\desktop\controller\Base;
use app\helper\DictionaryHelper;
use app\model\DictionaryModel;
use app\validate\IdValidate;
use app\validate\PaginationValidate;
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
        $get = $this->request->get(['type' => '', 'size' => '30', 'page' => '1']);

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = DictionaryModel::field('id,type');
        if ($get['type'] !== '') {
            $query->where('type', 'LIKE', '%' . $get['type'] . '%');
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
