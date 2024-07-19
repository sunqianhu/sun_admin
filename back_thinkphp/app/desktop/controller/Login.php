<?php

namespace app\desktop\controller;

use app\service\desktop\Session as SessionService;
use app\service\LoginFailChecker;
use app\validate\Session as SessionValidate;
use think\exception\ValidateException;
use Exception;

class Login extends Base
{
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
            validate(SessionValidate::class)->scene('desktop_login')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //登录次数
        $loginFailChecker = new LoginFailChecker($post['account']);
        if(!$loginFailChecker->check()){
            return $this->error('连续登录失败'.$loginFailChecker->number.'次，请'.$loginFailChecker->getResetReadableTime().'后再试');
        }

        try{
            $sessionService = new SessionService();
            $sessionEntity = $sessionService->login($post['account'], $post['password'], $this->request->ip());
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

        $data = [
            'user_id'=>$sessionEntity->userId,
            'token'=>$sessionEntity->token
        ];
        return $this->success('登录成功', $data);
    }
}