<?php

namespace app\desktop\controller;

use app\BaseController;
use app\helper\desktop\Jwt;
use app\model\desktop\Module as ModuleModel;
use app\model\OperationLog as OperationLogModel;
use app\model\UserRole as UserRoleModel;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    /**
     * @var string[] 不登录网址
     */
    private $noLoginUrls = [
        'desktop/login/getcaptcha',
        'desktop/login/login',
        'desktop/test/index'
    ];

    /**
     * @var string[] 不判断权限网址
     */
    private $noPermissionUrls = [
        'desktop/login/logout',
        'desktop/frame/getroutes',
        'desktop/frame/getpermissions',
        'desktop/frame/getwatermark',
        'desktop/main/init',
        'desktop/main/getmenus',
        'desktop/main/getavatar',
        'desktop/message/readall',
        'desktop/message/getnoreads',
        'desktop/uploadfile/upload',
        'desktop/my/info',
        'desktop/my/initeditavatar',
        'desktop/my/saveeditavatar',
        'desktop/my/editpassword'
    ];

    /**
     * @var 用户
     */
    public $user;

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();

        try {
            $this->auth();
        } catch (Exception $exception) {
            $message = $exception->getMessage();
            $code = 0;
            if(strpos($message, '登录已失效') !== false){
                $code = 2;
            }
            $this->error($message, null, $code)->send();
            exit;
        }

        $this->addOperationLog();
    }

    /**
     * 鉴权
     * @return void
     * @throws Exception
     */
    function auth()
    {
        $appName = app('http')->getName();
        $controller = $this->request->controller();
        $action = $this->request->action();
        $url = $appName . '/' . $controller . '/' . $action;
        $url = strtolower($url);

        //登录
        if (in_array($url, $this->noLoginUrls)) {
            return;
        }

        $token = $this->request->header('token', '');
        if (empty($token)) {
            throw new Exception('未获取到token');
        }

        $jwt = new Jwt();
        $user = $jwt->resolverToken($token);
        $this->user = $user;

        //权限
        if (in_array($url, $this->noPermissionUrls)) {
            return;
        }

        $roleIds = UserRoleModel::where('user_id', $this->user->id)
            ->group('role_id')
            ->column('role_id');
        if (empty($roleIds)) {
            throw new Exception('未设置角色');
        }

        $moduleModels = ModuleModel::alias('m')
            ->join('role_desktop_module rdm', 'm.id = rdm.module_id')
            ->field('m.api')
            ->where('rdm.role_id', 'in', $roleIds)
            ->where('m.api', '<>', '')
            ->group('m.id')
            ->append(['apis'])
            ->select();
        if ($moduleModels->isEmpty()) {
            throw new Exception('无权限');
        }

        $have = false;
        foreach ($moduleModels as $moduleModel) {
            $apis = $moduleModel->apis;
            if (empty($apis)) {
                continue;
            }
            $apis = array_map('strtolower', $apis);
            if (in_array($url, $apis)) {
                $have = true;
                break;
            }
        }
        if (!$have) {
            throw new Exception('无权限');
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
    public function error(string $message, $data = null)
    {
        $result = [
            'code' => 0,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }

    /**
     * 新增操作日志
     * @return void
     */
    public function addOperationLog()
    {
        if (empty($this->user->id)) {
            return;
        }

        //不记录公共页面
        $url = $this->request->baseUrl();
        $url = strtolower($url);

        $noSlashUrl = substr($url, 1);
        if (in_array($noSlashUrl, $this->noLoginUrls)) {
            return;
        }
        if (in_array($noSlashUrl, $this->noPermissionUrls)) {
            return;
        }

        //记录
        $data = [
            'user_id' => $this->user->id,
            'time' => time(),
            'ip' => $this->request->ip(),
            'url' => $url
        ];
        $operationLogModel = new OperationLogModel();
        $operationLogModel->save($data);
    }
}