<?php
declare (strict_types = 1);

namespace app\command;

use app\model\RoleModel;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;

class Test extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('test')
            ->setDescription('the test command');
    }

    protected function execute(Input $input, Output $output)
    {
        $message = new \app\service\MessageService();
        echo $message->queueSends([1], '你的B站2024年度报告来啦', '珍贵的回忆已经为你打包完毕！今年你登录B站多少天？谁成为了你的最爱？戳链接回顾2024，查收UP主送来的惊喜彩蛋', 'https:/www.baidu.com');
    }
}
