<?php

namespace app\desktop\controller;

use app\BaseController;
use app\entity\Session;
use app\model\OperationLogModel;
use app\service\CrudService;
use app\service\desktop\SessionService;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    public bool $isTokenAuth = true;
    public array $noTokenAuthActions = [];
    public bool $isApiAuth = true;
    public array $noApiAuthActions = [];
    public Session $session;

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
            $this->session = $sessionService->tokenAuth($token, $action);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 200, 2)->send();
            exit;
        }

        //接口
        try {
            $api = $this->request->baseUrl();
            $api = ltrim($api, '/');
            $sessionService->apiAuth($this->session->userId, $api, $action);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //操作日志
        if(
            $this->isTokenAuth &&
            !in_array($action, $this->noTokenAuthActions) &&
            $this->isApiAuth &&
            !in_array($action, $this->noApiAuthActions)
        ) {
            $operationLogCrudService = new CrudService(OperationLogModel::class);
            $data = [
                'user_id' => $this->session->userId,
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