<?php

namespace app\service\mobile;

use app\entity\SessionEntity;
use app\model\mobile\TokenModel;
use app\model\UserModel;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

class Jwt
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;
    public $expire = 60 * 60 * 24 * 30; //有效期

    /**
     * 得到token
     * @return string
     */
    function getToken($userId)
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
        $tokenModel = new TokenModel();
        $tokenModel->save($data);

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
        $tokenModel = TokenModel::where('token', $token)->find();
        if (empty($tokenModel)) {
            throw new Exception('未登录');
        }
        if ($tokenModel->expires_in < time()) {
            throw new Exception('登录已过期');
        }
        if ($tokenModel->user_id != $decoded->id) {
            throw new Exception('登录凭证错误');
        }

        //有效期
        $tokenModel->expires_in = time() + $this->expire;
        $tokenModel->save();

        $userModel = UserModel::find($tokenModel->user_id);
        if (empty($userModel)) {
            throw new Exception('没有找到用户记录');
        }

        $session = new SessionEntity();
        $session->userId = $userModel->id;
        $session->departmentId = $userModel->department_id;
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
        TokenModel::where('token', $token)->delete();
        return true;
    }
}