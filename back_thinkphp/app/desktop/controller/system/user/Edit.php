<?php

namespace app\desktop\controller\system\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\UserService;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class Edit extends Base
{
    /**
     * 初始化
     */
    public function init()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $user = UserModel::field('id,name,phone,department_id')
            ->with(['roles'])
            ->append(['role_ids'])
            ->find($id);
        if (empty($user)) {
            return $this->error('没有找到记录');
        }
        $userArray = $userService->toArray();

        return $this->success('获取成功', $userArray);
    }

    /**
     * 保存修改
     */
    public function save()
    {
        $post = $this->request->post(['id', 'name', 'phone', 'department_id', 'role_ids']);

        //验证
        try {
            validate(UserValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try{
            $userService = new UserService();
            $userService->edit($post['id'], $post);
        }catch (Exception $exception){
            return $this->error($exception->getMessage());
        }

        return $this->success('修改成功');
    }
}