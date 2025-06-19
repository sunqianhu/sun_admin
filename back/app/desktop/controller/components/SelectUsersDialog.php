<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\model\UserModel;
use think\db\exception\DbException;
use think\Response;

class SelectUsersDialog extends Base
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
        return $this->getSuccessResonse('获取成功', $paginateArray);
    }

    /**
     * 获取已选用户
     * @return Response
     */
    public function getSelectedUsers()
    {
        $get = $this->request->post(['ids' => []]);
        $userModels = UserModel::field('id,name')
            ->whereIn('id', $get['ids'])
            ->select();
        $users = $userModels->toArray();
        return $this->getSuccessResonse('获取成功', $users);
    }
}