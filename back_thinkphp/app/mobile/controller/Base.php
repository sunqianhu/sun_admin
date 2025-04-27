<?php

namespace app\mobile\controller;

use app\BaseController;
use app\model\OperationLogModel;
use app\service\CrudService;
use app\service\mobile\SessionService;
use Exception;
use think\Response;

/**
 * 基控制器
 */
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
        $sessionService = new SessionService();
        $sessionService->isTokenAuth = $this->isTokenAuth;
        $sessionService->noTokenAuthActions = $this->noTokenAuthActions;
        $sessionService->isApiAuth = $this->isApiAuth;
        $sessionService->noApiAuthActions = $this->noApiAuthActions;

        //ip
        try {
            $sessionService->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null)->send();
            exit;
        }

        $action = $this->request->action();

        //token
        try {
            $token = $this->request->header('token', '');
            $this->sessionId = $sessionService->tokenAuth($token, $action);
            if($this->sessionId) {
                $this->userId = $sessionService->getUserId($this->sessionId);
                $this->departmentId = $sessionService->getDepartmentId($this->sessionId);
            }
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 200, 2)->send();
            exit;
        }

        //路由
        try {
            $api = $this->request->baseUrl();
            $api = ltrim($api, '/');
            $sessionService->apiAuth($this->userId, $api, $action);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //操作日志
        if($this->sessionId) {
            $operationLogCrudService = new CrudService(OperationLogModel::class);
            $data = [
                'user_id' => $this->userId,
                'api' => $this->request->baseUrl(),
                'ip' => $this->request->ip(),
                'time' => time()
            ];
            $operationLogCrudService->insert($data);
        }
    }

    /**
     * 成功响应
     * @param string $message
     * @param $data
     * @param $code
     * @param $actionCode
     * @return Response
     */
    public function success(string $message, $data = null, $code = 200, $actionCode = 1)
    {
        $result = [
            'code' => $actionCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $code);
    }

    /**
     * 失败响应
     * @param string $message
     * @param $data
     * @param $code
     * @param $actionCode
     * @return Response
     */
    public function error(string $message, $data = null, $code = 200, $actionCode = 0)
    {
        $result = [
            'code' => $actionCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $code);
    }
}