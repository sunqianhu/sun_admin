<?php

namespace app\desktop\controller;

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
     * 登录
     * @return Response
     */
    public function login()
    {
        $post = $this->request->post(['account' => '', 'password' => '']);

        try {
            validate(LoginValidate::class)->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //登录次数
        $loginFailCheckerService = new LoginFailCheckerService($post['account']);
        if(!$loginFailCheckerService->check()){
            return $this->error('连续登录失败'.$loginFailCheckerService->number.'次，请'.$loginFailCheckerService->getResetReadableTime().'后再试');
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
            return $this->error($message);
        }
        $loginFailCheckerService->resetFail();

        $token = $sessionService->getToken($sessionId);

        return $this->success('登录成功', $token);
    }
}