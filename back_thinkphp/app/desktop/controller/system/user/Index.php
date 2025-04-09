<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\desktop\DesktopUserService;
use app\service\mobile\MobileUserService;
use app\service\UserService;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class Index extends Base
{
    /**
     * 获取用户分页
     */
    public function getUserPaginate()
    {
        $get = $this->request->get(['department_ids'=>[], 'role_id', 'account', 'name', 'phone', 'size' => 30, 'page' => 1]);

        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->field('u.id,u.account,u.name,u.phone,u.status,u.add_time,u.department_id')
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
            ->order('u.id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page']
        ]);
        $userPaginate = $paginate->toArray();

        return $this->success('获取成功', $userPaginate);
    }

    /**
     * 修改状态
     */
    function editStatus()
    {
        $post = $this->request->post(['id', 'status' => 0]);

        //验证
        try {
            validate(UserValidate::class)->scene('edit_status')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $post['status'] = $post['status'] == 1 ? 1 : 0;
        try{
            $userService = new UserService();
            $userService->editStatus($post['id'], $post['status']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }

    /**
     * 踢下线
     */
    function offLine()
    {
        $post = $this->request->post(['id']);

        //验证
        try {
            validate(UserValidate::class)->scene('offline')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $DesktopUserService = new DesktopUserService();
            $DesktopUserService->offLine($post['id']);

            $mobileUserService = new MobileUserService();
            $mobileUserService->offLine($post['id']);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('操作成功');
    }
}