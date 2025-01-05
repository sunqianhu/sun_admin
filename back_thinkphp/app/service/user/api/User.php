<?php

namespace app\service\user\api;

use app\model\api\TokenModel;

class User
{
    /**
     * 下线
     * @param $id
     * @return void
     */
    public function offLine($id){
        TokenModel::where('user_id', '=', $id)->delete();
    }
}