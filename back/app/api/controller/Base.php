<?php

namespace app\api\controller;

use app\BaseController;
use app\helper\ResponseHelper;
use app\helper\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\DepartmentHelper;
use Exception;
use think\exception\HttpResponseException;
use think\Response;

class Base extends BaseController
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public bool $isApiAuth = true; //是否接口认证
    public array $noApiAuthActions = []; //不需要接口认证的方法

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
        $action = $this->request->action();
        $ip = $this->request->ip();
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

        //token
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try{
                $token = $this->request->header('token', '');
                $this->request->sessionId = $sessionHelper->tokenAuth(2, $token);

                $this->request->userId = $sessionHelper->getUserId($this->request->sessionId);
                $departmentHelper = new DepartmentHelper();
                $this->request->departmentId = $departmentHelper->getDepartmentId($this->request->userId);
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
     * 得到错误响应
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
