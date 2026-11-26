<?php
declare (strict_types=1);

namespace app\command;

use app\helper\SessionHelper;
use Exception;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use think\facade\Config;
use Workerman\Connection\TcpConnection;
use Workerman\Timer;
use Workerman\Worker;

class WebsocketMessage extends Command
{
    /**
     * 容器
     * @var Worker
     */
    public Worker $worker;

    public $ttl = 3600;

    /**
     * 命令参数
     * @var array
     */
    private array $actions = ['start', 'stop', 'reload', 'restart', 'status'];

    protected function configure()
    {
        // 指令配置
        $this->setName('websocket_message')
            ->addArgument('action', Argument::OPTIONAL, "操作参数[start|stop|reload|restart|status]", 'start')
            ->addOption('daemon', null, Option::VALUE_OPTIONAL, '以守护进程运行')
            ->setDescription('系统消息，windows启动命令：php think websocket_message，linux启动命令：php think websocket_message start --daemon true');
    }

    /**
     * 执行
     * @param Input $input
     * @param Output $output
     * @return void
     * @throws Exception
     */
    protected function execute(Input $input, Output $output)
    {
        //linux系统命令参数
        if (strtolower(PHP_OS) == 'linux') {
            /**
             * 参数
             * 0：文件名（随意）
             * 1：参数
             * 2：选项
             */
            global $argv;
            $action = trim($input->getArgument('action'));
            if (!in_array($action, $this->actions)) {
                throw new Exception('action参数错误');
            }
            $argv[0] = 'websocket_message';
            $argv[1] = $action;
            if ($input->hasOption('daemon')) {
                $argv[2] = '-d';
            }
            if (isset($argv[3])) {
                unset($argv[3]);
            }
            if (isset($argv[4])) {
                unset($argv[4]);
            }
        }

        //容器
        $config = Config::get('message');
        if (!isset($config['websocket_listen_ip']) || !isset($config['websocket_port'])) {
            throw new Exception('还未配置监听ip或端口');
        }

        $url = 'websocket://' . $config['websocket_listen_ip'] . ':' . $config['websocket_port'];
        $this->worker = new Worker($url);
        $this->worker->name = 'websocket_message';
        $this->worker->count = 1;

        //事件
        $this->worker->onWorkerStart = [$this, 'handleWorkerStart'];
        $this->worker->onMessage = [$this, 'handleMessage'];

        Worker::runAll();
    }

    /**
     * 处理Worker启动
     * @param $worker
     * @return void
     */
    public function handleWorkerStart($worker)
    {
        try {
            $this->clearConnection($worker);
        } catch (Exception $exception) {
            echo $exception->getMessage() . PHP_EOL;
        }
    }

    /**
     * 处理消息
     * @param TcpConnection $connection
     * @param  $data
     * @return void
     */
    public function handleMessage(TcpConnection $connection, $data)
    {
        try {
            //活跃时间
            $connection->activeTime = time();

            //消息
            $decodeData = json_decode($data, true);
            if (empty($decodeData) || empty($decodeData['type'])) {
                throw new Exception('data数据格式错误，数据：'.$data);
            }

            //处理
            switch ($decodeData['type']) {
                //绑定
                case 'bind':
                    $this->bind($connection, $decodeData['token']);
                    break;
                //发送
                case 'send':
                    $this->send($decodeData);
                    break;
            }
        } catch (Exception $exception) {
            echo $exception->getMessage() . PHP_EOL;
        }
    }

    /**
     * 清理连接
     * @param $worker
     * @return void
     */
    public function clearConnection($worker)
    {
        Timer::add($this->ttl, function () use ($worker) {
            $time = time();
            foreach ($worker->connections as $connection) {
                if (empty($connection->activeTime)) {
                    $connection->activeTime = $time;
                    continue;
                }
                if ($time - $connection->activeTime > $this->ttl) {
                    $connection->close();
                }
            }
        });
    }

    /**
     * 绑定
     * @param $connection
     * @param $token
     * @return void
     * @throws Exception
     */
    public function bind(&$connection, $token)
    {
        if (empty($token)) {
            throw new Exception('token不能为空');
        }

        $sessionHelper = new SessionHelper();
        $connection->sessionId = $sessionHelper->tokenAuth(0, $token);
        $connection->userId = $sessionHelper->getUserId($connection->sessionId);
        $connection->token = $token;
        unset($sessionHelper);
    }

    /**
     * 发送
     * @param $decodeData
     * @return void
     * @throws Exception
     */
    public function send($decodeData)
    {
        if($decodeData['key'] !== md5('sun_admin_999')){
            throw new Exception('发送消息认证失败');
        }
        $userIds = $decodeData['user_ids'];
        if (empty($userIds)) {
            throw new Exception('接收消息userIds不能为空');
        }

        //消息
        $data = $decodeData['data'];
        $encodeData = json_encode($data);
        foreach ($this->worker->connections as $connection) {
            if (empty($connection->userId)) {
                continue;
            }
            if (!in_array($connection->userId, $userIds)) {
                continue;
            }
            $connection->send($encodeData);
        }
    }
}
