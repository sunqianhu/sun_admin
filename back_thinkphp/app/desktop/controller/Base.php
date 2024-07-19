<?php

namespace app\desktop\controller;

use app\BaseController;
use app\service\desktop\Session as SessionService;
use app\entity\desktop\Session as SessionEntity;
use app\service\OperationLog as OperationLogService;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    /**
     * @var SessionEntity 会话
     */
    public SessionEntity $session;

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();

        $this->session = new SessionEntity();
        $sessionService = new SessionService();

        //ip
        try {
            $sessionService->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //token
        try {
            $sessionEntity = $sessionService->tokenAuth($this->request);
            if(empty($sessionEntity)) {
                return;
            }
            $this->session = $sessionEntity;
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 2)->send();
            exit;
        }

        //路由
        try {
            $sessionService->ruoteAuth($this->request, $this->session->userId);
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //操作日志
        $operationLogService = new OperationLogService();
        $operationLogService->add($this->session->userId, $this->request->baseUrl(), $this->request->ip());
    }


    /**
     * 成功响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function success(string $message, $data = null)
    {
        $result = [
            'code' => 1,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }

    /**
     * 失败响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function error(string $message, $data = null, $code = 0)
    {
        $result = [
            'code' => $code,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }
}