<?php

namespace app\api\controller;

use app\BaseController;
use app\helper\SessionHelper;
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
    public bool $isApiAuth = true; //是否接口认证
    public array $noApiAuthActions = []; //不需要接口认证的方法
    public int $sessionId = 0;
    public int $userId = 0;
    public int $departmentId = 0;

    /**
     * 初始化
     * @return void
     * @throws Exception
     */
    function initialize()
    {
        parent::initialize();
        $sessionHelper = new SessionHelper();
        $action = $this->request->action();
        $ip = $this->request->ip();
        $api = $this->request->baseUrl();

        //ip
        $ipAuthHelper = new IpAuthHelper();
        try {
            $ipAuthHelper->ipAuth($ip);
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage(), 1, $exception);
        }

        //token
        if ($this->isTokenAuth && !in_array($action, $this->noTokenAuthActions)) {
            try {
                $token = $this->request->header('token', '');
                $this->request->sessionId = $sessionHelper->tokenAuth(2, $token);
            } catch (Exception $exception) {
                throw new Exception($exception->getMessage(), 2, $exception);
            }
        }

        if ($this->request->sessionId) {
            try {
                $this->request->userId = $sessionHelper->getUserId($this->request->sessionId);
                $userDepartmentHelper = new UserDepartmentHelper();
                $this->request->departmentId = $userDepartmentHelper->getDepartmentId($this->request->userId);
            } catch (Exception $exception) {
                throw new Exception($exception->getMessage(), 1, $exception);
            }
        }

        //接口认证
        if ($this->request->sessionId && $this->isApiAuth && !in_array($action, $this->noApiAuthActions)) {
            try {
                $sessionHelper->apiAuth($this->request->userId, $api);
            } catch (Exception $exception) {
                throw new Exception('接口认证失败，'.$exception->getMessage(), 1, $exception);
            }
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
    public function getSuccessResponse(string $message, $data = null, int $businessCode = 0, int $httpCode = 200)
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
    public function getErrorResponse(string $message, $data = null, int $businessCode = 1, int $httpCode = 200)
    {
        $result = [
            'code' => $businessCode,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', $httpCode);
    }
}
