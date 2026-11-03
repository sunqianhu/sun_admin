<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\helper\UserHelper;
use app\validate\user\UserSelectValidate;
use Exception;
use think\exception\ValidateException;
use think\Response;

class UserSelect extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到用户姓名
     * @return Response
     * @throws Exception
     */
    public function getUserName()
    {
        $get = $this->request->post(['user_id' => 0]);

        try {
            validate(UserSelectValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userHelper = new UserHelper();
        $userName = $userHelper->getName($get['user_id']);

        return $this->getSuccessResponse('获取成功', $userName);
    }
}