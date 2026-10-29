<?php

namespace app\mobile\controller;

use app\helper\SessionHelper;
use app\validate\LoginValidate;
use Exception;
use think\exception\ValidateException;
use think\Response;

class Login extends Base
{
    public bool $isTokenAuth = false;

    /**
     * 登录
     * @return Response
     * @throws Exception
     */
    public function login()
    {
        $post = $this->request->post(['account' => '', 'password' => '']);

        try {
            validate(LoginValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }

        try {
            $sessionHelper = new SessionHelper();
            $sessionId = $sessionHelper->login(
                1,
                $post['account'],
                $post['password'],
                $this->request->ip(),
                time() + 60 * 60 * 24 * 7
            );
            $token = $sessionHelper->getToken($sessionId);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('登录成功', $token);
    }
}
