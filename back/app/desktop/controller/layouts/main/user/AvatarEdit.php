<?php

namespace app\desktop\controller\layouts\main\user;

use app\desktop\controller\Base;
use app\model\UserModel;
use app\helper\user\UserAvatarHelper;
use app\validate\user\AvatarBase64ImageContentValidate;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\ValidateException;
use think\Response;

class AvatarEdit extends Base
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
        $userModel = UserModel::field('big_avatar')->find($this->request->userId);
        $url = $userModel->big_avatar_url;

        return $this->getSuccessResponse('获取成功', $url);
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

        $userAvatarHelper = new UserAvatarHelper();
        try {
            $userAvatarHelper->editAvatarByBase64Content($this->request->userId, $post['avatar_base64_image_content']);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('修改成功');
    }
}
