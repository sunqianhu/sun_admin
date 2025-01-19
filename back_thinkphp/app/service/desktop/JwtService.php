<?php

namespace app\service\desktop;

use app\entity\SessionEntity;
use app\service\UserService;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

class JwtService
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;
    public $expire = 60 * 30; //有效期

    /**
     * 得到token
     * @return string
     */
    function createToken($userId)
    {
        $payload = [
            'id' => $userId,
            'time' => time()
        ];
        $token = FirebaseJWT::encode($payload, $this->key, 'HS256');

        $data = [
            'token' => $token,
            'user_id' => $userId,
            'expires_in' => time() + $this->expire
        ];
        $tokenService = new TokenService();
        $tokenService->add($data);

        return $token;
    }

    /**
     * 解析token
     * @param $token
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    function resolverToken($token)
    {
        FirebaseJWT::$leeway = $this->leeway;
        try{
            $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));
        }catch (Exception $exception){
            throw new Exception('登录凭证错误['.$exception->getMessage().']');
        }

        //验证
        $tokenService = new TokenService();
        $tokenRecord = $tokenService->fieldFetch('token', $token);
        if (empty($tokenRecord)) {
            throw new Exception('未登录');
        }
        if ($tokenRecord['expires_in'] < time()) {
            throw new Exception('登录已过期');
        }
        if ($tokenRecord['user_id'] != $decoded->id) {
            throw new Exception('登录凭证错误');
        }

        //有效期
        $data = [
            'expires_in'=>time() + $this->expire
        ];
        $tokenService->edit($tokenRecord['id'], $data);

        $user = new UserService();
        $userRecord = $user->fetch($tokenRecord['user_id']);
        if (empty($userRecord)) {
            throw new Exception('没有找到用户记录');
        }

        $session = new SessionEntity();
        $session->userId = $userRecord['id'];
        $session->departmentId = $userRecord['department_id'];
        $session->token = $token;

        return $session;
    }

    /**
     * 删除token
     * @param $token
     * @return void
     */
    function deleteToken($token)
    {
        $tokenService = new TokenService();
        $tokenService->fieldDelete('token', $token);
    }
}