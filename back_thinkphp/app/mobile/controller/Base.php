<?php

namespace app\mobile\controller;

use app\BaseController;
use app\service\mobile\Session;
use app\entity\SessionEntity;
use app\service\OperationLog;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    public $isTokenAuth = true; //是否token认证
    public $noTokenAuthActions = []; //不需要token认证的方法
    public $isApiAuth = true; //是否接口认证
    public $noApiAuthActions = []; //不需要接口认证的方法
    public SessionEntity $session;

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();
        $session = new Session();
        $session->isTokenAuth = $this->isTokenAuth;
        $session->noTokenAuthActions = $this->noTokenAuthActions;
        $session->isApiAuth = $this->isApiAuth;
        $session->noApiAuthActions = $this->noApiAuthActions;

        //ip
        try {
            $session->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null)->send();
            exit;
        }

        $action = $this->request->action();

        //token
        try {
            $token = $this->request->header('token', '');
            $this->session = $session->tokenAuth($token, $action);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 200, 2)->send();
            exit;
        }

        //路由
        try {
            $route = $this->request->baseUrl();
            $route = ltrim($route, '/');
            $session->apiAuth($this->session->userId, $route, $action);
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
            $operationLog = new OperationLog();
            $operationLog->add($this->session->userId, $this->request->baseUrl(), $this->request->ip());
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