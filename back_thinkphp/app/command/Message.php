<?php
declare (strict_types=1);

namespace app\command;

use app\service\desktop\Jwt;
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

class Message extends Command
{
    /**
     * @var object 容器
     */
    public $worker;

    /**
     * @var string[] 命令参数
     */
    private $actions = ['start', 'stop', 'reload', 'restart', 'status'];

    protected function configure()
    {
        // 指令配置
        $this->setName('message')
            ->addArgument('action', Argument::OPTIONAL, "操作参数[start|stop|reload|restart|status]", 'start')
            ->addOption('daemon', null, Option::VALUE_OPTIONAL, '以守护进程运行')
            ->setDescription('系统消息，windows启动命令：php think message，linux启动命令：php think message start --daemon true');
    }

    /**
     * 执行
     * @param Input $input
     * @param Output $output
     * @return int|void|null
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
            $argv[0] = 'message';
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
        if (!isset($config['listen_ip']) || !isset($config['port'])) {
            throw new Exception('还未配置监听ip或端口');
        }

        $url = 'websocket://' . $config['listen_ip'] . ':' . $config['port'];
        $this->worker = new Worker($url);
        $this->worker->name = 'message';
        $this->worker->count = 1;

        //事件
        $this->worker->onWorkerStart = [$this, 'onWorkerStart'];
        $this->worker->onMessage = [$this, 'onMessage'];

        Worker::runAll();
    }

    /**
     * 子进程启动
     * @param $worker
     * @return void
     */
    public function onWorkerStart($worker)
    {
        try {
            $this->clear($worker);
        } catch (Exception $exception) {
            echo $exception->getMessage() . PHP_EOL;
        }
    }

    /**
     * 收到数据
     * @param TcpConnection $connection
     * @param $data 传输中的数据
     * @return void
     */
    public function onMessage(TcpConnection $connection, $data)
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
                    $this->send($decodeData['user_ids'], $decodeData['data']);
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
    public function clear($worker)
    {
        Timer::add(3600, function () use ($worker) {
            $time = time();
            foreach ($worker->connections as $connection) {
                if (empty($connection->activeTime)) {
                    $connection->activeTime = $time;
                    continue;
                }
                if ($time - $connection->activeTime > 3600) {
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

        $jwt = new Jwt();
        $session = $jwt->resolverToken($token);
        $connection->userId = $session->userId;

        unset($jwt);
        unset($session);
    }

    /**
     * 发送
     * @param $userIds
     * @param $data
     * @return void
     * @throws Exception
     */
    public function send($userIds, $data)
    {
        if (empty($userIds)) {
            throw new Exception('接收消息userIds不能为空');
        }

        //消息
        $encodeData = json_encode($data);

        //指定
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