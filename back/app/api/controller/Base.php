<?php

namespace app\api\controller;

use app\BaseController;
use app\model\OperationLogModel;
use app\service\api\SessionService;
use Sunqianhu\Helper\thinkphp\Crud;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    public bool $isTokenAuth = true; //是否token认证
    public array $noTokenAuthActions = []; //不需要token认证的方法
    public int $sessionId = 0;
    public int $userId = 0;

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

        //ip
        try {
            $sessionService->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->getErrorResponse($exception->getMessage())->send();
            exit;
        }

        $action = $this->request->action();

        //token
        try {
            $token = $this->request->header('token', '');
            $this->sessionId = $sessionService->tokenAuth($token, $action);
            if($this->sessionId){
                $this->userId = $sessionService->getUserId($this->sessionId);
            }
        } catch (Exception $exception) {
            $this->getErrorResponse($exception->getMessage(), null, 2)->send();
            exit;
        }

        //操作日志
        if($this->sessionId) {
            $operationLogCrud = new Crud(OperationLogModel::class);
            $data = [
                'user_id' => $this->userId,
                'api' => $this->request->baseUrl(),
                'ip' => $this->request->ip(),
                'time' => time()
            ];
            $operationLogCrud->insert($data);
        }
    }

    /**
     * 得到成功响应
     * @param string $message
     * @param $data
     * @param $businessCode
     * @param $httpCode
     * @return Response
     */
    public function getSuccessResponse(string $message, $data = null, $businessCode = 1, $httpCode = 200)
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
     * @param $businessCode
     * @param $httpCode
     * @return Response
     */
    public function getErrorResponse(string $message, $data = null, $businessCode = 0, $httpCode = 200)
    {
        $result = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $httpCode);
    }
}