<?php

namespace app\service\mobile\session;

use app\entity\mobile\Session as SessionEntity;
use app\entity\User as UserEntity;
use app\model\mobile\Token as TokenModel;
use app\model\User as UserModel;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;
use Exception;

class Jwt
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;
    public $expire = 60 * 60 * 24 * 365; //有效期

    /**
     * 得到token
     * @param UserEntity $userEntity
     * @return token
     */
    function getToken(UserEntity $userEntity)
    {
        $payload = [
            'id' => $userEntity->id,
            'name' => $userEntity->name,
            'department_id' => $userEntity->departmentId,
            'time' => microtime()
        ];
        $token = FirebaseJWT::encode($payload, $this->key, 'HS256');

        $data = [
            'token' => $token,
            'user_id' => $userEntity->id,
            'expires_in' => time() + $this->expire
        ];
        $tokenModel = new TokenModel();
        $tokenModel->save($data);

        return $token;
    }

    /**
     * 解析token
     * @param $token
     * @return SessionEntity
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws Exception
     */
    function resolverToken($token)
    {
        FirebaseJWT::$leeway = $this->leeway;
        $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));

        //验证
        $tokenModel = TokenModel::where('token', $token)->find();
        if (empty($tokenModel)) {
            throw new Exception('登录已失效');
        }
        if ($tokenModel->expires_in < time()) {
            throw new Exception('登录已过期');
        }
        if ($tokenModel->user_id != $decoded->id) {
            throw new Exception('登录凭证错误');
        }

        // 有效期
        $tokenModel->expires_in = time() + $this->expire;
        $tokenModel->save();

        $userModel = UserModel::find($tokenModel->user_id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户');
        }

        $sessionEntity = new SessionEntity();
        $sessionEntity->userId = $userModel->id;
        $sessionEntity->departmentId = $userModel->department_id;
        $sessionEntity->token = $token;

        return $sessionEntity;
    }

    /**
     * 删除token
     * @param $token
     * @return void
     */
    function deleteToken($token)
    {
        TokenModel::where('token', $token)->delete();
        return true;
    }
}