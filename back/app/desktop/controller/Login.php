<?php

namespace app\desktop\controller;

use app\helper\ConfigHelper;
use app\helper\SessionHelper;
use app\validate\LoginValidate;
use think\exception\ValidateException;
use Exception;
use think\Response;

class Login extends Base
{
    public bool $isTokenAuth = false;

    /**
     * 初始化
     * @return Response
     * @throws Exception
     */
    public function init()
    {
        $configHelper = new ConfigHelper();
        $systemName = $configHelper->getValue('system_name');
        $data = [
            'system_name' => $systemName
        ];
        return $this->getSuccessResponse('获取成功', $data);
    }

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
                0,
                $post['account'],
                $post['password'],
                $this->request->ip(),
                time() + 30 * 60
            );
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        $token = $sessionHelper->getToken($sessionId);

        return $this->getSuccessResponse('登录成功', $token);
    }
}
