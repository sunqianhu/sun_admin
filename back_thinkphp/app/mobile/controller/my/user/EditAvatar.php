<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\validate\user\AvatarBase64ImageContentValidate;
use Sunqianhu\Helper\File;
use app\service\UserService;
use Exception;
use think\exception\ValidateException;
use think\Response;

class EditAvatar extends Base
{
    public bool $isApiAuth = false;

    /**
     * 保存
     * @return Response
     * @throws Exception
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
            $path = $userService->editAvatarByBase64ImageContent($this->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);
        return $this->success('修改成功', $url);
    }
}