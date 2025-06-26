<?php

namespace app\desktop\controller;

use app\service\ConfigService;
use app\service\desktop\SessionService;
use app\service\LoginFailCheckerService;
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
        $configService = new ConfigService();
        $systemName = $configService->getValue('system_name');
        $data = [
            'system_name' => $systemName
        ];
        return $this->getSuccessResonse('获取成功', $data);
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

        //登录次数
        $loginFailCheckerService = new LoginFailCheckerService($post['account']);
        if(!$loginFailCheckerService->check()){
            return $this->getErrorResponse('连续登录失败'.$loginFailCheckerService->number.'次，请'.$loginFailCheckerService->getResetReadableTime().'后再试');
        }

        try{
            $sessionService = new SessionService();
            $sessionId = $sessionService->login($post['account'], $post['password'], $this->request->ip());
        }catch (Exception $exception){
            $loginFailCheckerService->setFail();
            $availableNumber = $loginFailCheckerService->getAvailableNumber();
            $message = $exception->getMessage();
            if($availableNumber > 0){
                $message .= '，还能再试'.$availableNumber.'次';
            }else{
                $message .= '，连续登录失败'.$loginFailCheckerService->number.'次，请'.$loginFailCheckerService->getResetReadableTime().'后再试';
            }
            return $this->getErrorResponse($message);
        }
        $loginFailCheckerService->resetFail();

        $token = $sessionService->getToken($sessionId);

        return $this->getSuccessResonse('登录成功', $token);
    }
}