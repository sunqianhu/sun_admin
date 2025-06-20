<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\service\UserService;
use app\validate\user\AvatarBase64ImageContentValidate;
use Sunqianhu\Helper\File;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class EditAvatar extends Base
{
    public bool $isApiAuth = false;

    /**
     * 初始化
     * @return Response
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    public function init()
    {
        $userModel = UserModel::field('avatar')->find($this->userId);
        $avatar = $userModel->avatar_url;

        return $this->getSuccessResonse('获取成功', $avatar);
    }

    /**
     * 保存
     * @return Response
     */
    public function save()
    {
        $post = $this->request->post(['avatar_base64_image_content']);

        try {
            validate(AvatarBase64ImageContentValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userService = new UserService();
        try {
            $path = $userService->editAvatarByBase64Content($this->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        $file = new File();
        $url = $file->getUrl($path);

        return $this->getSuccessResonse('修改成功', $url);
    }
}