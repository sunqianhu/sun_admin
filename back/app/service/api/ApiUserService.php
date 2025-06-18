<?php

namespace app\service\api;

use app\model\api\SessionModel;
use Sunqianhu\Helper\thinkphp\Crud;
use Exception;

class ApiUserService
{
    /**
     * 下线
     * @param $id
     * @return void
     * @throws Exception
     */
    public function offLine($id)
    {
        $sessionCrud = new Crud(SessionModel::class);
        $sessionCrud->deleteByField('user_id', $id);
    }
}