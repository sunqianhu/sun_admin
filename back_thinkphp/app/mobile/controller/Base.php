<?php

namespace app\mobile\controller;

use app\BaseController;
use app\service\mobile\Session as Session;
use app\entity\mobile\Session as SessionEntity;
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
        $session = new Session();

        //ip
        try {
            $session->ipAuth($this->request->ip());
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }

        //token
        try {
            $sessionEntity = $session->tokenAuth($this->request);
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
            $session->ruoteAuth($this->request, $this->session->userId);
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