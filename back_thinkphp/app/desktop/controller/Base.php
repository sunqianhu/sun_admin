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

//        $sessionService = new SessionService();
//        try {
//            $session = $sessionService->auth($this->request);
//            if($session == null){
//                return;
//            }
//            $this->session = $session;
//        } catch (Exception $exception) {
//            $message = $exception->getMessage();
//            $this->error($message, null, 2)->send();
//            exit;
//        }
//
//        $operationLogService = new OperationLogService();
//        $operationLogService->add($this->session->user->id, $this->request->baseUrl(), $this->request->ip());
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
    public function error(string $message, $data = null)
    {
        $result = [
            'code' => 0,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }
}