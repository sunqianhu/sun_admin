<?php
declare (strict_types = 1);

namespace app\command;

use app\service\api\session\Jwt as JwtService;
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
            ->setDescription('生成api token');
    }

    protected function execute(Input $input, Output $output)
    {
        $userEntity = new UserEntity();
        $userEntity->id = 1;
        $userEntity->name = '张三';
        $userEntity->departmentId = 1;
        $jwtService = new JwtService();
        $token = $jwtService->getToken($userEntity);
        $userEntity = $jwtService->resolverToken($token);
        //print_r($userEntity);
    }
}
