<?php

namespace app\mobile\controller;

use app\service\mobile\SessionService;
use app\service\LoginFailCheckerService;
use app\validate\LoginValidate;
use Exception;
use think\exception\ValidateException;

class Login extends Base
{
    public $isTokenAuth = false;

    /**
     * 登录
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
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
        $loginFailChecker = new LoginFailCheckerService($post['account']);
        if(!$loginFailChecker->check()){
            return $this->error('连续登录失败'.$loginFailChecker->number.'次，请'.$loginFailChecker->getResetReadableTime().'后再试');
        }

        try{
            $sessionService = new SessionService();
            $session = $sessionService->login($post['account'], $post['password'], $this->request->ip());
        }catch (Exception $exception){
            $loginFailChecker->setFail();
            $availableNumber = $loginFailChecker->getAvailableNumber();
            $message = $exception->getMessage();
            if($availableNumber > 0){
                $message .= '，还能再试'.$availableNumber.'次';
            }else{
                $message .= '，连续登录失败'.$loginFailChecker->number.'次，请'.$loginFailChecker->getResetReadableTime().'后再试';
            }
            return $this->error($message);
        }
        $loginFailChecker->resetFail();

        $token = $session->token;
        return $this->success('登录成功', $token);
    }
}