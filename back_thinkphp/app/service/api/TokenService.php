<?php

namespace app\service\api;

use app\model\api\TokenModel;
use app\service\CrudService;
use Exception;

class TokenService extends CrudService
{
    /**
     * 构造函数
     * @throws Exception
     */
    public function __construct()
    {
        parent::__construct(TokenModel::class);
    }
}