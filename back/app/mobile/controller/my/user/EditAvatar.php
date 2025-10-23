<?php

namespace app\mobile\controller\my\user;

use app\mobile\controller\Base;
use app\helper\user\UserAvatarHelper;
use app\validate\user\AvatarBase64ImageContentValidate;
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
            return $this->getErrorResponse($exception->getError());
        }

        try {
            $userAvatarHelper = new UserAvatarHelper();
            $userAvatarHelper->editAvatarByBase64Content($this->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }
        $url = $userAvatarHelper->getAvatarUrlByUserId($this->userId);

        return $this->getSuccessResponse('修改成功', $url);
    }
}