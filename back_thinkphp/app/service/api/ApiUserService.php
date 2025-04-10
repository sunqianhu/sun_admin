<?php

namespace app\service\api;

use app\model\api\TokenModel;
use app\service\CrudService;
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
        $tokenCrudService = new CrudService(TokenModel::class);
        $tokenCrudService->deleteByField('user_id', $id);
    }
}