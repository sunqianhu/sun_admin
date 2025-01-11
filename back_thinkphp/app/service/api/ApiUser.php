<?php

namespace app\service\api;

class ApiUser
{
    /**
     * 下线
     * @param $id
     * @return void
     */
    public function offLine($id){
        $token = new Token();
        $token->fieldDelete('user_id', $id);
    }
}