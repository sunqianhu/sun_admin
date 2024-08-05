<?php

namespace app\desktop\controller\main\user;

use app\desktop\controller\Base;
use app\model\User as UserModel;
use app\service\File as FileService;
use app\service\User as UserService;
use app\validate\User as UserValidate;
use Exception;
use think\exception\ValidateException;

class EditAvatar extends Base
{
    /**
     * 初始化
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $userModel = UserModel::field('avatar')->find($this->session->userId);
        $avatar = $userModel->avatar_url;

        return $this->success('获取成功', $avatar);
    }

    /**
     * 保存
     * @return \think\Response
     */
    public function save()
    {
        $post = $this->request->post(['avatar_base64_content']);

        try {
            validate(UserValidate::class)->scene('desktop_main_edit_avatar')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try {
            $userService = new UserService();
            $path = $userService->editAvatar($this->session->userId, $post['avatar_base64_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $fileService = new FileService();
        $url = $fileService->getUrl($path);

        return $this->success('修改成功', $url);
    }
}