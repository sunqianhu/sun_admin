<?php

namespace app\desktop\controller;

use app\BaseController;
use app\helper\OperationLogHelper;
use app\helper\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\exception\HttpResponseException;
use think\Response;
use think\facade\Log;
use Throwable;

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

        try {
            //ip
            $ipAuthHelper = new IpAuthHelper();
            try {
                $ipAuthHelper->ipAuth($ip);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse($exception->getMessage())
                );
            }

            //token认证
            $token = $this->request->header('token', '');
            if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
                try {
                    $this->sessionId = $sessionHelper->tokenAuth(0, $token);
                } catch (Exception $exception) {
                    throw new HttpResponseException(
                        $this->getErrorResponse('登录认证失败，'.$exception->getMessage(), null, 2)
                    );
                }
            }

            if(!empty($this->sessionId)){
                try{
                    $this->userId = $sessionHelper->getUserId($this->sessionId);
                    $userDepartmentHelper = new UserDepartmentHelper();
                    $this->departmentId = $userDepartmentHelper->getDepartmentId($this->userId);
                    $sessionHelper->renewExpireTime($this->sessionId, time() + 30 * 60);
                }catch (Exception $exception){
                    throw new HttpResponseException(
                        $this->getErrorResponse($exception->getMessage())
                    );
                }
            }

            //接口认证
            if ($this->sessionId) {
                if ($this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
                    try {
                        $sessionHelper->apiAuth($this->userId, $api);
                    } catch (Exception $exception) {
                        throw new HttpResponseException(
                            $this->getErrorResponse('接口认证失败，'.$exception->getMessage())
                        );
                    }
                }
            }
        } finally {
            $operationLogHelper = new OperationLogHelper();
            $data = [
                'department_id' => $this->departmentId,
                'user_id' => $this->userId,
                'terminal' => 0,
                'api' => $api,
                'request_method' => $this->request->method(true),
                'request_content' => $operationLogHelper->getRequestContent($this->request),
                'ip' => $ip,
                'time' => time()
            ];
            $operationLogHelper->add($data);
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
