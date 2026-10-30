<?php

namespace app\desktop\controller;

use app\BaseController;
use app\helper\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\Response;

class Base extends BaseController
{
    public bool $isTokenAuth = true;
    public array $noTokenAuthActions = [];
    public bool $isApiAuth = true;
    public array $noApiAuthActions = [];
    public int $sessionId = 0;
    public int $userId = 0;
    public int $departmentId = 0;

    /**
     * 初始化
     * @return void
     * @throws Exception
     */
    function initialize()
    {
        parent::initialize();
        $sessionHelper = new SessionHelper();
        $ip = $this->request->ip();
        $action = $this->request->action();
        $api = $this->request->baseUrl();

        //ip
        $ipAuthHelper = new IpAuthHelper();
        $ipAuthHelper->ipAuth($ip);

        //token认证
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try {
                $token = $this->request->header('token', '');
                $this->request->sessionId = $sessionHelper->tokenAuth(0, $token);
            } catch (Exception $exception) {
                throw new Exception('登录认证失败，'.$exception->getMessage(), 2, $exception);
            }
        }

        if(!empty($this->request->sessionId)){
            try{
                $this->request->userId = $sessionHelper->getUserId($this->request->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->request->departmentId = $userDepartmentHelper->getDepartmentId($this->request->userId);
                $sessionHelper->renewExpireTime($this->request->sessionId, time() + 30 * 60);
            }catch (Exception $exception){
                throw new Exception($exception->getMessage(), 1, $exception);
            }
        }

        //接口认证
        if ($this->request->sessionId) {
            if ($this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
                try {
                    $sessionHelper->apiAuth($this->request->userId, $api);
                } catch (Exception $exception) {
                    throw new Exception('接口认证失败，'.$exception->getMessage(), 1, $exception);
                }
            }
        }
    }

    /**
     * 得到成功响应
     * @param string $message
     * @param $data
     * @param int $businessCode
     * @param int $httpCode
     * @return Response
     */
    public function getSuccessResponse(string $message, $data = null, int $businessCode = 0, int $httpCode = 200)
    {
        $result = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $httpCode);
    }

    /**
     * 得到失败响应
     * @param string $message
     * @param $data
     * @param int $businessCode
     * @param int $httpCode
     * @return Response
     */
    public function getErrorResponse(string $message, $data = null, int $businessCode = 1, int $httpCode = 200)
    {
        $responseData = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($responseData, 'json', $httpCode);
    }
}
