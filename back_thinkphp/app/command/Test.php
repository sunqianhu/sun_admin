<?php
declare (strict_types = 1);

namespace app\command;

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
        $message = new \app\service\Message();
        $message->sendByQueue([1,2,3,4,5,6,7,8,9,10], '测试', '/desktop/Test/index');
        // 指令输出
        $output->writeln('test');
    }
}
