<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\UserModel;
use think\db\exception\DbException;
use think\Response;

class UserSelectorDialog extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到分页
     * @return Response
     * @throws DbException
     */
    public function getPaginate()
    {
        $get = $this->request->get(['department_ids' => [], 'keyword' => '', 'size' => '30', 'page' => '1']);
        $query = UserModel::field('id,name,department_id')
            ->with(['department' => function ($query) {
                $query->withField('id,name');
            }]);
        if (!empty($get['department_ids'])) {
            $query->whereIn('department_id', $get['department_ids']);
        }
        if ($get['keyword'] !== '') {
            $query->where(function ($query) use ($get){
                $query->where('name', 'LIKE', '%' . $get['keyword'] . '%')
                    ->whereOr('phone', 'LIKE', '%' . $get['keyword'] . '%');
            });
        }
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginateArray = $paginate->toArray();
        return $this->getSuccessResponse('获取成功', $paginateArray);
    }
}