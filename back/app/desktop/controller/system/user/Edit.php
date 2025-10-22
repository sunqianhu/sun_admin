<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\model\UserRoleModel;
use app\service\UserService;
use app\validate\UserValidate;
use Exception;
use think\db\Query;
use think\exception\ValidateException;
use think\facade\Db;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->getErrorResponse('id参数错误');
        }

        $userModel = UserModel::field('id,name,phone,department_id')
            ->with(['roles'=>function (Query $query) {
                $query->field('id,name')
                    ->hidden(['pivot']);
            }])
            ->append(['role_ids'])
            ->find($id);
        if (empty($userModel)) {
            return $this->getErrorResponse('没有找到记录');
        }
        $user = $userModel->toArray();

        return $this->getSuccessResponse('获取成功', $user);
    }

    /**
     * 保存修改
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name', 'phone', 'department_id', 'role_ids']);

        try {
            validate(UserValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        Db::startTrans();
        try{
            $userService = new UserService();
            $userService->edit($post['id'], $post);
            $id = $post['id'];

            $userRoleModels = UserRoleModel::where('user_id', $id)->select();
            $userRoleModels->delete();
            foreach ($post['role_ids'] as $roleId){
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id' => $id,
                    'role_id' => $roleId
                ]);
            }

            Db::commit();
        }catch (Exception $exception){
            Db::rollback();
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}