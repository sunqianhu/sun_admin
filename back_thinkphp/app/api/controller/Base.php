<?php


use app\BaseController;
use app\service\api\Session as SessionService;
use app\entity\api\Session as SessionEntity;
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
        try {
            $sessionService->ipAuth($this->request->ip());
            $this->session = $sessionService->tokenAuth($this->request->header('token', ''));
        } catch (Exception $exception) {
            $this->error($exception->getMessage(), null, 0)->send();
            exit;
        }
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