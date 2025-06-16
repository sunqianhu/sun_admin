<?php

namespace app\service\api;

use app\model\api\SessionModel;
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
        $sessionCrudService = new CrudService(SessionModel::class);
        $sessionCrudService->deleteByField('user_id', $id);
    }
}