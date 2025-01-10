<?php

namespace app\service\api;

use app\model\api\TokenModel;
use app\service\Curd;
use Exception;

class Token extends Curd
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(TokenModel::class);
    }

    /**
     * token删除
     * @param $token
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function tokenDelete($token)
    {
        $token = TokenModel::where('token', $token)->find();
        if(empty($token)){
            throw new Exception('没有找到token记录');
        }
        $token->delete();
    }

    /**
     * 用户删除
     * @param $userId
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function userDelete($userId)
    {
        $token = TokenModel::where('user_id', $userId)->find();
        if(empty($token)){
            throw new Exception('没有找到token记录');
        }
        $token->delete();
    }
}