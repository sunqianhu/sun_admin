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
        $message = new \app\service\Message();
        echo $message->queueSends([1], '标题', '内容', 'https:/www.baidu.com');
    }
}
