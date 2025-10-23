<?php

namespace app\mobile\controller;

use app\BaseController;
use app\model\OperationLogModel;
use app\helper\IpAuthHelper;
use app\helper\mobile\SessionHelper;
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
     */
    function initialize()
    {
        parent::initialize();
        $sessionHelper = new SessionHelper();

        //ip
        $ipAuthHelper = new IpAuthHelper();
        try {
            $ipAuthHelper->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->getErrorResponse($exception->getMessage())->send();
            exit;
        }

        $action = $this->request->action();

        //token
        $token = $this->request->header('token', '');
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try {
                $this->sessionId = $sessionHelper->tokenAuth($token);
            } catch (Exception $exception) {
                $this->getErrorResponse($exception->getMessage(), null, 2)->send();
                exit;
            }
        }

        if ($this->sessionId) {
            try {
                //token续期
                $this->userId = $sessionHelper->getUserId($this->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->departmentId = $userDepartmentHelper->getDepartmentId($this->userId);
                $sessionHelper->renewExpiresIn($this->sessionId);

                //接口
                if ($this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
                    $api = $this->request->baseUrl();
                    $sessionHelper->apiAuth($this->userId, $api);
                }
            } catch (Exception $exception) {
                $this->getErrorResponse($exception->getMessage())->send();
                exit;
            }
        }

        //操作日志
        if ($this->sessionId) {
            $operationLogModel = new OperationLogModel();
            $data = [
                'department_id' => $this->departmentId,
                'user_id' => $this->userId,
                'terminal' => 1,
                'api' => $this->request->baseUrl(),
                'ip' => $this->request->ip(),
                'time' => time()
            ];
            $operationLogModel->save($data);
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
    public function getSuccessResponse(string $message, $data = null, int $businessCode = 1, int $httpCode = 200)
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
    public function getErrorResponse(string $message, $data = null, int $businessCode = 0, int $httpCode = 200)
    {
        $responseData = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($responseData, 'json', $httpCode);
    }
}