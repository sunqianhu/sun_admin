<?php

namespace app\desktop\controller\system\api_token_generate;

use app\desktop\controller\Base;
use app\helper\api\SessionHelper;
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
            $token = $jwtHelper->generateToken(4);

            $sessionHelper = new SessionHelper();
            $sessionHelper->createSession(4, $token);
        }catch (Exception $exception){
            return $this->getErrorResponse($exception->getMessage());
        }

        return $this->getSuccessResponse('创建成功', $token);
    }
}