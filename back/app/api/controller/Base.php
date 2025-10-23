<?php

namespace app\api\controller;

use app\BaseController;
use app\model\OperationLogModel;
use app\helper\api\SessionHelper;
use app\helper\IpAuthHelper;
use app\helper\user\UserDepartmentHelper;
use Exception;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
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
    public int $sessionId = 0;
    public int $userId = 0;
    public int $departmentId = 0;

    /**
     * 初始化
     * @return void
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
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
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            $token = $this->request->header('token', '');
            try {
                $this->sessionId = $sessionHelper->tokenAuth($token);
            } catch (Exception $exception) {
                $this->getErrorResponse($exception->getMessage(), null, 2)->send();
                exit;
            }
        }

        if ($this->sessionId) {
            try {
                $this->userId = $sessionHelper->getUserId($this->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->departmentId = $userDepartmentHelper->getDepartmentId($this->userId);
                $sessionHelper->renewExpiresIn($this->sessionId);
            } catch (Exception $exception) {
                $this->getErrorResponse($exception->getMessage())->send();
                exit;
            }
        }

        //操作日志
        if ($this->userId) {
            $operationLogModel = new OperationLogModel();
            $data = [
                'department_id' => $this->departmentId,
                'user_id' => $this->userId,
                'terminal' => 2,
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
    public function getErrorResponse(string $message, $data = null, int $businessCode = 0, int $httpCode = 200)
    {
        $result = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $httpCode);
    }
}