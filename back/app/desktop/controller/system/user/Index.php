<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\helper\desktop\SessionHelper as DesktopSessionHelper;
use app\helper\mobile\SessionHelper as MobileSessionHelper;
use app\helper\user\UserStatusHelper;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 获取分页
     */
    public function getPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'role_id', 'account', 'name', 'phone', 'size' => 30, 'page' => 1]);

        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->field('u.id,u.account,u.name,u.phone,u.status,u.add_time,u.department_id,u.avatar')
            ->with('department');
        if (!empty($get['department_ids'])) {
            $query->whereIn('u.department_id', $get['department_ids']);
        }
        if (!empty($get['role_id'])) {
            $query->where('ur.role_id', '=', $get['role_id']);
        }
        if (isset($get['account']) && $get['account'] !== '') {
            $query->where('u.account', 'LIKE', '%' . $get['account'] . '%');
        }
        if (isset($get['name']) && $get['name'] !== '') {
            $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if (isset($get['phone']) && $get['phone'] !== '') {
            $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query->group('u.id')
            ->order('u.id', 'desc')
            ->append(['avatar_url']);
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page']
        ]);
        $paginateArray = $paginate->toArray();

        return $this->getSuccessResponse('获取成功', $paginateArray);
    }

    /**
     * 修改状态
     */
    function editStatus()
    {
        $post = $this->request->post(['id', 'status' => 0]);

        try {
            validate(UserValidate::class)->scene('edit_status')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $status = $post['status'] == 1 ? 1 : 0;
        $userStatusHelper = new UserStatusHelper();
        try{
            $userStatusHelper->editStatus($post['id'], $status);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }

    /**
     * 踢下线
     */
    function offLine()
    {
        $post = $this->request->post(['id']);

        try {
            validate(UserValidate::class)->scene('offline')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try{
            $desktopSessionHelper = new DesktopSessionHelper();
            $desktopSessionHelper->deleteSessionByUserId($post['id']);

            $mobileSessionHelper = new MobileSessionHelper();
            $mobileSessionHelper->deleteSessionByUserId($post['id']);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('操作成功');
    }
}