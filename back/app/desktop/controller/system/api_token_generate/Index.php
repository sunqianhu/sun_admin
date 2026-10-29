<?php

namespace app\desktop\controller\system\api_token_generate;

use app\desktop\controller\Base;
use app\helper\SessionHelper;
use app\helper\JwtHelper;
use Exception;
use think\response;

class Index extends Base
{
    /**
     * 生成
     * @return response
     */
    public function generate()
    {
        try{
            $jwtHelper = new JwtHelper();
            $token = $jwtHelper->generateToken($this->userId);

            $sessionHelper = new SessionHelper();
            $data = [
                'user_id' => $this->userId,
                'terminal' => 2,
                'token' => $token,
                'expire_time' => time() + 60 * 60 * 24 * 365 * 5
            ];
            $sessionHelper->add($data);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('创建成功', $token);
    }
}
