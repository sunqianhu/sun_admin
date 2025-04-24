<?php

namespace app\service\api;

use app\entity\Session;
use app\model\api\TokenModel;
use app\model\UserModel;
use app\service\CrudService;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class JwtService
{
    private string $key = 'axjeJXKlA836x7s@#';
    private int $leeway = 180;
    public int $expire = 60 * 60 * 24 * 365; //有效期

    /**
     * 创建token
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
        $tokenCrudService->insert($data);

        return $token;
    }

    /**
     * 解析token
     * @param $token
     * @return Session
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
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
        $tokenRecord = $tokenCrudService->selectRowByField('token', $token);
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
        $tokenCrudService->update($tokenRecord['id'], $data);

        $userCrudService = new CrudService(UserModel::class);
        $user = $userCrudService->selectRow($tokenRecord['user_id']);
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