<?php

namespace app\desktop\controller\layouts\side\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\File as File;
use app\service\User;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class EditAvatar extends Base
{
    public $isApiAuth = false;

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
        $post = $this->request->post(['avatar_base64_image_content']);

        try {
            validate(UserValidate::class)->scene('my_edit_avatar')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try {
            $user = new User();
            $path = $user->editAvatar($this->session->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);

        return $this->success('修改成功', $url);
    }
}