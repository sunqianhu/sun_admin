<?php

namespace app\service\desktop;

use app\model\desktop\TokenModel;
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