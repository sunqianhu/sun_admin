<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\service\FileService;
use app\service\UserService;
use app\validate\UserValidate;
use Exception;
use think\exception\ValidateException;

class EditAvatar extends Base
{
    public $isApiAuth = false;

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
            $user = new UserService();
            $path = $user->editAvatar($this->session->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $file = new FileService();
        $url = $file->getUrl($path);
        return $this->success('修改成功', $url);
    }
}