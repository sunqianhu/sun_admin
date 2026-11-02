<?php

namespace app\desktop\controller;

use app\BaseController;
use app\helper\ResponseHelper;
use app\helper\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\exception\HttpResponseException;
use think\Response;

class Base extends BaseController
{
    public bool $isTokenAuth = true;
    public array $noTokenAuthActions = [];
    public bool $isApiAuth = true;
    public array $noApiAuthActions = [];

    /**
     * 初始化
     * @return void
     * @throws Exception
     */
    function initialize()
    {
        parent::initialize();
        $this->auth();
    }

    /**
     * 认证
     * @return void
     */
    public function auth()
    {
        $sessionHelper = new SessionHelper();
        $ip = $this->request->ip();
        $action = $this->request->action();
        $api = $this->request->baseUrl();

        //ip
        try{
            $ipAuthHelper = new IpAuthHelper();
            $ipAuthHelper->ipAuth($ip);
        } catch (Exception $exception) {
            throw new HttpResponseException(
                $this->getErrorResponse('IP认证失败，' . $exception->getMessage())
            );
        }

        //token认证
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try {
                $token = $this->request->header('token', '');
                $this->request->sessionId = $sessionHelper->tokenAuth(0, $token);

                $this->request->userId = $sessionHelper->getUserId($this->request->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->request->departmentId = $userDepartmentHelper->getDepartmentId($this->request->userId);
                $sessionHelper->renewExpireTime($this->request->sessionId, time() + 30 * 60);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse('身份认证失败，' . $exception->getMessage(), null, 2)
                );
            }
        }

        //接口认证
        if ($this->isTokenAuth && $this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
            try{
                $sessionHelper->apiAuth($this->request->userId, $api);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse('接口认证失败，' . $exception->getMessage())
                );
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
        $responseHelper = new ResponseHelper();
        return $responseHelper->getSuccessResponse($message, $data, $businessCode, $httpCode);
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
        $responseHelper = new ResponseHelper();
        return $responseHelper->getErrorResponse($message, $data, $businessCode, $httpCode);
    }
}
