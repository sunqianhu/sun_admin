<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\user\UserDataScopeHelper;
use app\model\UserModel;
use app\validate\PaginationValidate;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class UsersSelectDialog extends Base
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

        try {
            validate(PaginationValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $query = UserModel::field('id,name,department_id')
            ->with(['department' => function ($query) {
                $query->withField('id,name');
            }]);
        $userDataScopeHelper = new UserDataScopeHelper();
        $query = $userDataScopeHelper->buildQueryConstraint($this->request->userId, 'global_user_access', $query, 'department_id', 'id');
        if (!empty($get['department_ids'])) {
            $query->whereIn('department_id', $get['department_ids']);
        }
        if ($get['keyword'] !== '') {
            $query->where(function ($query) use ($get){
                $query->where('name', 'LIKE', '%' . $get['keyword'] . '%')
                    ->whereOr('phone', 'LIKE', '%' . $get['keyword'] . '%');
            });
        }
        $paginateObject = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        $paginate = $paginateObject->toArray();
        return $this->getSuccessResponse('获取成功', $paginate);
    }

    /**
     * 获取已选用户
     * @return Response
     * @throws DbException
     * @throws DataNotFoundException
     * @throws ModelNotFoundException
     */
    public function getSelectedUsers()
    {
        $get = $this->request->post(['user_ids' => []]);
        $query = UserModel::field('id,name')
            ->whereIn('id', $get['user_ids']);
        $userDataScopeHelper = new UserDataScopeHelper();
        $query = $userDataScopeHelper->buildQueryConstraint($this->request->userId, 'global_user_access', $query, 'department_id', 'id');
        $userModels = $query->select();
        $users = $userModels->toArray();
        return $this->getSuccessResponse('获取成功', $users);
    }
}
