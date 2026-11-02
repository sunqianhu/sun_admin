<?php

namespace app\desktop\controller\system\session;

use app\desktop\controller\Base;
use app\helper\JwtHelper;
use app\helper\SessionHelper;
use app\validate\SessionValidate;
use Exception;
use think\exception\ValidateException;

class Add extends Base
{
    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['name' => '', 'terminal' => '', 'user_id' => 0, 'expire_time' => 0]);
        try {
            validate(SessionValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->getErrorResponse($exception->getError());
        }
        try {
            $data = $post;
            $jwtHelper = new JwtHelper();
            $data['token'] = $jwtHelper->generateToken($post['user_id']);
            $sessionHelper = new SessionHelper();
            $sessionHelper->add($data);
        } catch (Exception $exception) {
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('添加成功');
    }
}
