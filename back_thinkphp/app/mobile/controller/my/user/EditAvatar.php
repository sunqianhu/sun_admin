<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\model\User as UserModel;
use app\service\File as FileService;
use app\service\User as UserService;
use app\validate\User as UserValidate;
use Exception;
use think\exception\ValidateException;

class EditAvatar extends Base
{
    /**
     * 保存
     * @return \think\Response
     */
    public function save()
    {
        $post = $this->request->post(['avatar_base64_content']);

        try {
            validate(UserValidate::class)->scene('mobile_my_edit_avatar')->check($post);
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