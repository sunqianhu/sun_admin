<?php

namespace app\desktop\controller\components;

use app\desktop\controller\Base;
use app\service\UserService;
use app\validate\components\SelectUserValidate;
use think\exception\ValidateException;
use think\Response;

class SelectUser extends Base
{
    public bool $isApiAuth = false;

    /**
     * 得到用户姓名
     * @return Response
     */
    public function getUserName()
    {
        $get = $this->request->post(['user_id' => 0]);

        try {
            validate(SelectUserValidate::class)->check($get);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        $userService = new UserService();
        $userName = $userService->getName($get['user_id']);

        return $this->getSuccessResonse('获取成功', $userName);
    }
}