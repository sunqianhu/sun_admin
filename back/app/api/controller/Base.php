<?php

namespace app\api\controller;

use app\BaseController;
use app\model\OperationLogModel;
use app\helper\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\exception\HttpResponseException;
use think\Response;

class Base extends BaseController
{
    /**
     * 是否token认证
     * @var bool
     */
    public bool $isTokenAuth = true;
    /**
     * 不需要token认证的方法
     * @var array
     */
    public array $noTokenAuthActions = [];
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
        $ip = $this->request->ip();
        $api = $this->request->baseUrl();

        //ip
        $ipAuthHelper = new IpAuthHelper();
        try {
            $ipAuthHelper->ipAuth($ip);
        } catch (Exception $exception) {
            throw new HttpResponseException(
                $this->getErrorResponse($exception->getMessage())
            );
        }

        $action = $this->request->action();

        //token
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            $token = $this->request->header('token', '');
            try {
                $this->sessionId = $sessionHelper->tokenAuth(2, $token);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse($exception->getMessage())
                );
            }
        }

        if ($this->sessionId) {
            try {
                $this->userId = $sessionHelper->getUserId($this->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->departmentId = $userDepartmentHelper->getDepartmentId($this->userId);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse($exception->getMessage())
                );
            }
        }

        //接口认证
        if ($this->sessionId && $this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
            try {
                $sessionHelper->apiAuth($this->userId, $api);
            } catch (Exception $exception) {
                throw new HttpResponseException(
                    $this->getErrorResponse('接口认证失败，'.$exception->getMessage())
                );
            }
        }

        //操作日志
        if ($this->userId) {
            $operationLogModel = new OperationLogModel();
            $data = [
                'department_id' => $this->departmentId,
                'user_id' => $this->userId,
                'terminal' => 2,
                'api' => $api,
                'ip' => $ip,
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
     * 得到错误响应
     * @param string $message
     * @param $data
     * @param int $businessCode
     * @param int $httpCode
     * @return Response
     */
    public function getErrorResponse(string $message, $data = null, int $businessCode = 1, int $httpCode = 200)
    {
        $result = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $httpCode);
    }
}
