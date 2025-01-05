<?php

namespace app\desktop\controller;

use app\BaseController;
use app\service\desktop\Session;
use app\service\OperationLog;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    /**
     * @var bool 是否ip认证
     */
    public $isIpAuth = true;
    /**
     * 是否登录认证
     * @var bool
     */
    public $isTokenAuth = true;
    /**
     * 是否路由权限认证
     * @var bool
     */
    public $isRouteAuth = true;

    public $session;

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();
        $session = new Session();
        $session->isIpAuth = $this->isIpAuth;
        $session->isTokenAuth = $this->isTokenAuth;
        $session->isRouteAuth = $this->isRouteAuth;

        //ip
        try {
            $session->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //token
        try {
            $this->session = $session->tokenAuth($this->request);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 2)->send();
            exit;
        }

        //路由
        try {
            $session->ruoteAuth($this->request, $this->session->userId);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //操作日志
        if($this->isTokenAuth) {
            $operationLogService = new OperationLog();
            $operationLogService->add($this->session->userId, $this->request->baseUrl(), $this->request->ip());
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