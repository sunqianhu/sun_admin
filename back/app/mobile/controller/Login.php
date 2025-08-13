<?php

namespace app\mobile\controller;

use app\service\mobile\SessionService;
use app\service\LoginCountCheckerService;
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

        //登录次数
        $loginCountCheckerService = new LoginCountCheckerService($post['account']);
        if(!$loginCountCheckerService->check()){
            return $this->getErrorResponse('连续登录失败'.$loginCountCheckerService->number.'次，请'.$loginCountCheckerService->getResetReadableTime().'后再试');
        }

        try{
            $sessionService = new SessionService();
            $sessionId = $sessionService->login($post['account'], $post['password'], $this->request->ip());
        }catch (Exception $exception){
            $loginCountCheckerService->setFail();
            $availableNumber = $loginCountCheckerService->getAvailableNumber();
            $message = $exception->getMessage();
            if($availableNumber > 0){
                $message .= '，还能再试'.$availableNumber.'次';
            }else{
                $message .= '，连续登录失败'.$loginCountCheckerService->number.'次，请'.$loginCountCheckerService->getResetReadableTime().'后再试';
            }
            return $this->getErrorResponse($message);
        }
        $loginCountCheckerService->resetFail();

        $token = $sessionService->getToken($sessionId);
        return $this->getSuccessResponse('登录成功', $token);
    }
}