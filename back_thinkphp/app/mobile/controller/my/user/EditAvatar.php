<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\validate\user\AvatarBase64ImageContentValidate;
use Sunqianhu\Helper\File;
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
            validate(AvatarBase64ImageContentValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        try {
            $userService = new UserService();
            $path = $userService->editAvatarByBase64ImageContent($this->session->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);
        return $this->success('修改成功', $url);
    }
}