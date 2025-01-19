<?php

namespace app\service\api;

class ApiUserService
{
    /**
     * 下线
     * @param $id
     * @return void
     */
    public function offLine($id){
        $token = new TokenService();
        $token->fieldDelete('user_id', $id);
    }
}