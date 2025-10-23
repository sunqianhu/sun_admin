<?php

namespace app\desktop\controller;

use app\helper\ConfigHelper;
use app\helper\desktop\SessionHelper;
use app\helper\LoginCountCheckerHelper;
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

        //登录次数
        $loginCountCheckerHelper = new LoginCountCheckerHelper($post['account']);
        if(!$loginCountCheckerHelper->check()){
            return $this->getErrorResponse('连续登录失败'.$loginCountCheckerHelper->number.'次，请'.$loginCountCheckerHelper->getResetReadableTime().'后再试');
        }

        try{
            $sessionHelper = new SessionHelper();
            $sessionId = $sessionHelper->login($post['account'], $post['password'], $this->request->ip());
        }catch (Exception $exception){
            $loginCountCheckerHelper->setFail();
            $availableNumber = $loginCountCheckerHelper->getAvailableNumber();
            $message = $exception->getMessage();
            if($availableNumber > 0){
                $message .= '，还能再试'.$availableNumber.'次';
            }else{
                $message .= '，连续登录失败'.$loginCountCheckerHelper->number.'次，请'.$loginCountCheckerHelper->getResetReadableTime().'后再试';
            }
            return $this->getErrorResponse($message);
        }
        $loginCountCheckerHelper->resetFail();

        $token = $sessionHelper->getToken($sessionId);

        return $this->getSuccessResponse('登录成功', $token);
    }
}