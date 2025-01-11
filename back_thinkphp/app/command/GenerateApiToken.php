<?php
declare (strict_types = 1);

namespace app\command;

use app\service\api\Jwt;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;

class GenerateApiToken extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('generate_api_token')
            ->addArgument('user_id', Argument::REQUIRED, "用户id")
            ->setDescription('生成api token');
    }

    protected function execute(Input $input, Output $output)
    {
        $userId = trim($input->getArgument('user_id')) ?? 1;

        $jwt = new Jwt();
        echo $token = $jwt->createToken($userId);
    }
}
