<?php

namespace app\helper;

use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;
use think\facade\Config;

class JwtHelper
{
    private string $key = '';
    private int $leeway = 180;

    /**
     * @throws Exception
     */
    public function __construct()
    {
        $key = Config::get('app.jwt_key');
        if($key === null){
            throw new Exception('请配置项目会话令牌key');
        }
        $this->key = $key;
    }

    /**
     * 生成token
     * @return string
     */
    function generateToken($userId)
    {
        $payload = [
            'user_id' => $userId,
            'time' => time()
        ];
        return FirebaseJWT::encode($payload, $this->key, 'HS256');
    }

    /**
     * 解析token
     * @param $token
     * @return int
     * @throws Exception
     */
    function resolverToken($token)
    {
        FirebaseJWT::$leeway = $this->leeway;
        try{
            $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));
        }catch (Exception $exception){
            throw new Exception('登录凭证错误['.$exception->getMessage().']', 0, $exception);
        }

        if(empty($decoded->user_id)){
            throw new Exception('登录凭证错误');
        }

        return $decoded->user_id;
    }
}
