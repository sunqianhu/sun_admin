<?php

namespace app\service\mobile;

use app\entity\Session;
use app\model\mobile\TokenModel;
use app\model\UserModel;
use app\service\CrudService;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

class JwtService
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;
    public $expire = 60 * 60 * 24 * 30; //有效期

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
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenCrudService->add($data);

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
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenRecord = $tokenCrudService->findByField('token', $token);
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
        $tokenCrudService->edit($tokenRecord['id'], $data);

        $userCrudService = new CrudService(UserModel::class);
        $user = $userCrudService->find($tokenRecord['user_id']);
        if (empty($user)) {
            throw new Exception('没有找到用户记录');
        }

        $session = new Session();
        $session->userId = $user['id'];
        $session->departmentId = $user['department_id'];
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
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenCrudService->deleteByField('token', $token);
    }
}