<?php

namespace app\mobile\controller;

use app\BaseController;
use app\helper\IpAuthHelper;
use app\helper\SessionHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\Response;

class Base extends BaseController
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public bool $isApiAuth = true; //是否接口认证
    public array $noApiAuthActions = []; //不需要接口认证的方法
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
        $action = $this->request->action();
        $ip = $this->request->ip();
        $api = $this->request->baseUrl();

        //ip
        $ipAuthHelper = new IpAuthHelper();
        try {
            $ipAuthHelper->ipAuth($ip);
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage(), 1, $exception);
        }

        //token
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try {
                $token = $this->request->header('token', '');
                $this->sessionId = $sessionHelper->tokenAuth(1, $token);
            } catch (Exception $exception) {
                throw new Exception('登录认证失败，'.$exception->getMessage(), 2, $exception);
            }
        }

        if ($this->sessionId) {
            try{
                $this->userId = $sessionHelper->getUserId($this->sessionId);
                $this->request->userId = $this->userId;
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->departmentId = $userDepartmentHelper->getDepartmentId($this->userId);
                $this->request->departmentId = $this->departmentId;
                $sessionHelper->renewExpireTime($this->sessionId, time() + 60 * 60 * 24 * 7);
            }catch (Exception $exception){
                throw new Exception($exception->getMessage(), 1, $exception);
            }
        }

        //接口认证
        if ($this->sessionId) {
            if ($this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
                try {
                    $sessionHelper->apiAuth($this->userId, $api);
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
        $responseData = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($responseData, 'json', $httpCode);
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
